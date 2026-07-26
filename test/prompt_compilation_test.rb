# frozen_string_literal: true

require "fileutils"
require "tmpdir"
require "test/unit"
require_relative "../tools/lib/prompt_compilation"

class PromptCompilationTest < Test::Unit::TestCase
  ROOT = File.expand_path("..", __dir__)
  PROFILE = "knowledge/prompt_development/legendary/L010_joshua.yaml"
  ENVIRONMENT = {"SOURCE_DATE_EPOCH" => "1_700_000_000".delete("_"), "SOURCE_COMMIT" => "a" * 40}.freeze

  def setup
    @compiler = PromptCompilation::Compiler.new(root: ROOT, env: ENVIRONMENT)
  end

  def test_compilation_is_repeatable_and_traceable
    Dir.mktmpdir do |directory|
      first_dir, first = compile(directory)
      second_dir, second = compile(directory)

      assert_equal(first_dir, second_dir)
      assert_equal(first, second)
      manifest = YAML.safe_load(first.fetch("manifest.yaml"))
      traceability = YAML.safe_load(first.fetch("traceability.yaml"))
      assert_equal("a" * 40, manifest.fetch("source_commit"))
      assert_equal("2023-11-14T22:13:20Z", manifest.fetch("compiled_at"))
      assert_true(traceability.fetch("complete"))
      assert_include(traceability.fetch("canonical_sources"), "knowledge/characters/legendary/L010_joshua/data/art.yaml")
    end
  end

  def test_adapters_do_not_change_canonical_model
    Dir.mktmpdir do |directory|
      canonical_prompts = PromptCompilation::ADAPTERS.keys.map do |adapter|
        _, files = @compiler.compile(profile_path: PROFILE, output_root: directory, adapter: adapter)
        files.fetch("canonical_prompt.yaml")
      end
      assert_equal(1, canonical_prompts.uniq.length)
    end
  end

  def test_drift_check_detects_manual_edits
    Dir.mktmpdir do |directory|
      output, files = compile(directory)
      @compiler.write(output, files)
      @compiler.write(output, files, check: true)
      output.join("prompt.txt").write("manual edit\n")
      assert_raise(PromptCompilation::Error) { @compiler.write(output, files, check: true) }
    end
  end

  private

  def compile(directory)
    @compiler.compile(profile_path: PROFILE, output_root: directory, adapter: "openai", model: "test-model", seed: 42, resolution: "1024x1536")
  end
end
