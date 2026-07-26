# frozen_string_literal: true

require "digest"
require "fileutils"
require "json"
require "open3"
require "pathname"
require "time"
require "yaml"

module PromptCompilation
  COMPILER_VERSION = "1.0.0"
  SECTION_ORDER = %w[identity biblical_grounding gameplay_influence visual_identity wardrobe environment composition lighting rendering_language prohibited_elements].freeze

  class Error < StandardError; end

  CanonicalPrompt = Struct.new(*SECTION_ORDER.map(&:to_sym), keyword_init: true) do
    def to_h
      PromptCompilation::SECTION_ORDER.to_h { |name| [name, public_send(name)] }
    end
  end

  class Adapter
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def adapt(model)
      {
        "positive_prompt" => positive(model),
        "negative_prompt" => Array(model.prohibited_elements).join(", ")
      }
    end

    private

    def positive(model)
      SECTION_ORDER.reject { |section| section == "prohibited_elements" }
                   .flat_map { |section| Array(model.public_send(section)) }
                   .map(&:to_s).map(&:strip).reject(&:empty?).join(" ")
    end
  end

  class OpenAIAdapter < Adapter
    def initialize = super("openai")
  end

  class FluxAdapter < Adapter
    def initialize = super("flux")
  end

  class SDXLAdapter < Adapter
    def initialize = super("sdxl")
  end

  ADAPTERS = {"openai" => OpenAIAdapter, "flux" => FluxAdapter, "sdxl" => SDXLAdapter}.freeze

  class Compiler
    attr_reader :root

    def initialize(root: File.expand_path("../..", __dir__), env: ENV)
      @root = Pathname(root).expand_path
      @env = env
    end

    def compile(profile_path:, output_root:, adapter: "openai", model: nil, seed: 0, resolution: "1024x1536")
      profile_file = resolve(profile_path)
      profile = load_yaml(profile_file)
      validate_profile!(profile, profile_file)
      adapter_instance = build_adapter(adapter)
      canonical_files = canonical_sources(profile)
      template_file = root.join("templates/production/generation_manifest.yaml")
      prompt = build_model(profile)
      adapted = adapter_instance.adapt(prompt)
      version = profile.fetch("schema_version")
      output_dir = resolve(output_root).join(profile.fetch("collector_id"), "v#{version}", adapter_instance.name)
      metadata = regeneration_metadata(profile_file, canonical_files + [template_file])
      manifest = load_yaml(template_file).merge(
        "schema_version" => "1.0.0",
        "character_id" => profile.fetch("collector_id"),
        "prompt_version" => version,
        "compiler_version" => COMPILER_VERSION,
        "adapter" => adapter_instance.name,
        "model" => model || default_model(adapter_instance.name),
        "seed" => Integer(seed),
        "resolution" => resolution,
        "source_commit" => metadata.fetch("source_commit"),
        "source_profile" => relative(profile_file),
        "compiled_at" => metadata.fetch("compiled_at"),
        "artifact_state" => "NOT_GENERATED",
        "source_hashes" => metadata.fetch("source_hashes")
      )
      traceability = traceability_report(profile, profile_file, canonical_files, adapted)

      files = {
        "prompt.txt" => "#{adapted.fetch("positive_prompt")}\n",
        "negative_prompt.txt" => "#{adapted.fetch("negative_prompt")}\n",
        "canonical_prompt.yaml" => dump_yaml(prompt.to_h),
        "manifest.yaml" => dump_yaml(manifest),
        "traceability.yaml" => dump_yaml(traceability),
        "regeneration.json" => "#{JSON.pretty_generate(metadata.merge("command" => regeneration_command(manifest)))}\n"
      }
      [output_dir, files]
    end

    def write(output_dir, files, check: false)
      if check
        drift = files.keys.select { |name| !output_dir.join(name).file? || output_dir.join(name).binread != files.fetch(name).b }
        extras = output_dir.directory? ? output_dir.children.select(&:file?).map { |p| p.basename.to_s } - files.keys : []
        drift.concat(extras.sort)
        raise Error, "generated prompt drift: #{drift.join(', ')}" unless drift.empty?
        return
      end

      FileUtils.mkdir_p(output_dir)
      files.each { |name, content| output_dir.join(name).binwrite(content) }
    end

    private

    def build_adapter(name)
      adapter_class = ADAPTERS[name]
      raise Error, "unknown adapter #{name.inspect}; choose #{ADAPTERS.keys.join(', ')}" unless adapter_class

      adapter_class.new
    end

    def build_model(profile)
      identity = profile.fetch("identity")
      biblical = profile.fetch("biblical_basis")
      visual = profile.fetch("visual_identity")
      composition = profile.fetch("composition")
      art = profile.fetch("art_direction")
      CanonicalPrompt.new(
        identity: ["A vertical full-art collectible illustration of #{profile.fetch('character_name')}, #{identity.fetch('legendary_title')}, #{identity.fetch('depicted_life_stage')} in the #{identity.fetch('era')} (#{identity.fetch('culture')})."],
        biblical_grounding: [biblical.fetch("defining_scene"), "Biblical grounding: #{biblical.fetch('primary_passages').join(', ')}."],
        gameplay_influence: [profile.fetch("gameplay_identity").fetch("strategic_identity")],
        visual_identity: visual.fetch("presentation") + visual.fetch("materials") + visual.fetch("signature_objects"),
        wardrobe: visual.fetch("wardrobe") + visual.fetch("accessories"),
        environment: visual.fetch("environment") + visual.fetch("supporting_figures"),
        composition: [composition.fetch("focal_action"), composition.fetch("pose"), composition.fetch("camera")] + composition.fetch("foreground") + composition.fetch("middle_ground") + composition.fetch("background") + [composition.fetch("card_frame_safe_space"), "Vertical 2:3 aspect ratio."],
        lighting: art.fetch("lighting") + art.fetch("palette"),
        rendering_language: art.fetch("rendering_language") + art.fetch("textures"),
        prohibited_elements: split_exclusions(art.fetch("prohibited_elements"))
      )
    end

    def split_exclusions(values)
      values.flat_map { |value| value.split(/;\s*|,\s*/) }.map(&:strip).reject(&:empty?).uniq
    end

    def validate_profile!(profile, file)
      required = %w[schema_version collector_id character_name identity biblical_basis gameplay_identity visual_identity composition art_direction traceability]
      missing = required.reject { |key| profile.key?(key) }
      raise Error, "#{relative(file)} missing fields: #{missing.join(', ')}" unless missing.empty?
      raise Error, "unresolved placeholder in #{relative(file)}" if file.read.match?(/\{\{[^}]+\}\}|\b(?:TBD|TODO)\b/i)
    end

    def canonical_sources(profile)
      paths = profile.dig("traceability", "prompt_clauses").to_a.flat_map { |clause| clause.fetch("source_paths", []) }
      paths.filter_map do |source|
        next if source.match?(/\A(?:Scripture:|[a-z_]+(?:\.[a-z_]+)*)\z/)
        path = resolve(source)
        path if path.file?
      end.uniq.sort_by { |path| relative(path) }
    end

    def traceability_report(profile, profile_file, canonical_files, adapted)
      clauses = profile.dig("traceability", "prompt_clauses").to_a
      {
        "schema_version" => "1.0.0",
        "character_id" => profile.fetch("collector_id"),
        "complete" => !clauses.empty? && clauses.all? { |clause| !clause.fetch("source_paths", []).empty? },
        "source_profile" => relative(profile_file),
        "canonical_sources" => canonical_files.map { |path| relative(path) },
        "prompt_clauses" => clauses,
        "output_hashes" => {
          "positive_prompt_sha256" => Digest::SHA256.hexdigest(adapted.fetch("positive_prompt")),
          "negative_prompt_sha256" => Digest::SHA256.hexdigest(adapted.fetch("negative_prompt"))
        }
      }
    end

    def regeneration_metadata(profile_file, canonical_files)
      sources = ([profile_file] + canonical_files).uniq.sort_by { |path| relative(path) }
      epoch = if @env["SOURCE_DATE_EPOCH"]
                Integer(@env.fetch("SOURCE_DATE_EPOCH"))
              else
                git(%w[show -s --format=%ct HEAD]).to_i
              end
      {
        "source_commit" => @env["SOURCE_COMMIT"] || git(%w[rev-parse HEAD]),
        "compiled_at" => Time.at(epoch).utc.iso8601,
        "source_hashes" => sources.to_h { |path| [relative(path), Digest::SHA256.file(path).hexdigest] }
      }
    end

    def regeneration_command(manifest)
      "ruby tools/compile_prompts.rb --profile #{manifest.fetch('source_profile')} --adapter #{manifest.fetch('adapter')} --model #{manifest.fetch('model')} --seed #{manifest.fetch('seed')} --resolution #{manifest.fetch('resolution')}"
    end

    def default_model(adapter)
      {"openai" => "gpt-image-1", "flux" => "flux-1.1-pro", "sdxl" => "sdxl-1.0"}.fetch(adapter)
    end

    def load_yaml(path)
      YAML.safe_load(path.read, permitted_classes: [], aliases: false) || {}
    rescue Psych::Exception => e
      raise Error, "cannot parse #{relative(path)}: #{e.message}"
    end

    def dump_yaml(object) = YAML.dump(object)
    def resolve(path) = Pathname(path).absolute? ? Pathname(path) : root.join(path)
    def relative(path) = Pathname(path).relative_path_from(root).to_s

    def git(arguments)
      output, status = Open3.capture2("git", *arguments, chdir: root.to_s)
      raise Error, "git #{arguments.join(' ')} failed" unless status.success?
      output.strip
    end
  end
end
