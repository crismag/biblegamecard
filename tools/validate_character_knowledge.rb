#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"
require "json"
require "pathname"
require "set"
require "digest"
require "open3"
require "English"
require_relative "lib/canonical_support"

ROOT = Pathname.new(__dir__).parent.expand_path
USAGE = "Usage: ruby tools/validate_character_knowledge.rb [--all] [--verbose] PACKAGE_DATA_DIR"
if ARGV.delete("--help")
  puts USAGE
  exit 0
end
verbose = ARGV.delete("--verbose")
if ARGV.delete("--all")
  dirs = CanonicalSupport.package_dirs(ROOT)
  if dirs.empty?
    warn "No canonical manifests found"
    exit 2
  end
  failures = dirs.count do |dir|
    system(RbConfig.ruby, __FILE__, *(verbose ? ["--verbose"] : []), dir.relative_path_from(ROOT).to_s)
    !$CHILD_STATUS.success?
  end
  puts "#{failures.zero? ? 'PASS' : 'FAIL'}: #{dirs.length} canonical package(s) validated"
  exit(failures.zero? ? 0 : 1)
end
if ARGV.length != 1
  warn USAGE
  exit 2
end
package_dir = Pathname.new(ARGV.first)
package_dir = ROOT.join(package_dir) unless package_dir.absolute?
errors = []

load_yaml = lambda do |path|
  CanonicalSupport.safe_yaml(path)
rescue CanonicalSupport::LoadError, Errno::ENOENT => e
  display = path.absolute? && path.to_s.start_with?(ROOT.to_s) ? path.relative_path_from(ROOT) : path
  errors << "#{display}: YAML load failed: #{e.message}"
  {}
end

manifest = load_yaml.call(package_dir.join("manifest.yaml"))
document_names = %w[character references timeline relationships symbols gameplay art prompt review version_history]
docs = {}
document_names.each do |name|
  relative = manifest.dig("documents", name)
  if relative.nil?
    errors << "manifest.documents.#{name}: required document path is missing"
    next
  end
  path = package_dir.join(relative)
  errors << "manifest.documents.#{name}: file does not exist: #{path}" unless path.file?
  docs[name] = load_yaml.call(path) if path.file?
end

schema_path = ROOT.join(manifest["master_schema"].to_s)
if !schema_path.file?
  errors << "manifest.master_schema: file does not exist"
else
  begin
    schema = JSON.parse(schema_path.read)
    assembled = {"manifest" => manifest}.merge(docs)
    CanonicalSupport::SchemaValidator.new(schema).validate(assembled).each do |violation|
      safe_value = violation.value.inspect[0, 160]
      errors << "Schema #{violation.path}: #{violation.message} (rule #{violation.rule}; value #{safe_value})"
    end
  rescue JSON::ParserError, ArgumentError, KeyError => e
    errors << "manifest.master_schema: schema configuration failed: #{e.message}"
  end
end

registries = {}
%w[entities locations symbols].each do |name|
  path = ROOT.join(manifest.dig("registries", name).to_s)
  errors << "manifest.registries.#{name}: file does not exist" unless path.file?
  registries[name] = load_yaml.call(path) if path.file?
end

semver = /\A\d+\.\d+\.\d+\z/
id_pattern = /\A[A-Z][A-Z0-9_]*\z/
ref_pattern = /\AREF_[A-Z0-9_]+\z/
event_pattern = /\AEVT_[A-Z0-9_]+\z/
relationship_pattern = /\AREL_[A-Z0-9_]+\z/
states = %w[draft prototype review_requested changes_requested validated theology_approved gameplay_approved art_direction_approved prompt_approved art_approved card_approved production_approved blocked released deprecated]

errors << "manifest.schema_version: must be semantic version" unless manifest["schema_version"].to_s.match?(semver)
errors << "manifest.collector_id: must match A000" unless manifest["collector_id"].to_s.match?(/\A[A-Z]\d{3}\z/)
errors << "manifest.package_version: must be semantic version" unless manifest["package_version"].to_s.match?(semver)
errors << "manifest.knowledge_version: must be semantic version" unless manifest["knowledge_version"].to_s.match?(semver)

character_id = manifest["character_id"]
docs.each do |name, document|
  errors << "#{name}.schema_version: must be semantic version" unless document["schema_version"].to_s.match?(semver)
  errors << "#{name}.character_id: #{document["character_id"].inspect} does not match #{character_id}" unless document["character_id"] == character_id
end

unique_index = lambda do |items, key, label, pattern = id_pattern|
  ids = items.to_a.map { |item| item[key] }
  ids.each { |id| errors << "#{label}: invalid ID #{id.inspect}" unless id.to_s.match?(pattern) }
  ids.tally.select { |_id, count| count > 1 }.each_key { |id| errors << "#{label}: duplicate ID #{id}" }
  ids.to_set
end

entity_ids = unique_index.call(registries.dig("entities", "entities"), "id", "entity registry")
location_items = registries.dig("locations", "locations").to_a
location_ids = unique_index.call(location_items, "id", "location registry")
symbol_ids = unique_index.call(registries.dig("symbols", "symbols"), "id", "symbol registry")
location_items.each do |location|
  parent = location["parent_id"]
  errors << "location #{location["id"]}: unknown parent #{parent}" if parent && !location_ids.include?(parent)
end

references = docs.dig("references", "references").to_a
reference_ids = unique_index.call(references, "id", "references", ref_pattern)
references.each do |reference|
  errors << "reference #{reference["id"]}: testament must be old or new" unless %w[old new].include?(reference["testament"])
  errors << "reference #{reference["id"]}: book is required" if reference["book"].to_s.empty?
  errors << "reference #{reference["id"]}: importance must be primary or supporting" unless %w[primary supporting].include?(reference["importance"])
  segments = reference["segments"].to_a
  errors << "reference #{reference["id"]}: at least one segment is required" if segments.empty?
  segments.each_with_index do |segment, index|
    %w[chapter verse_start verse_end].each { |field| errors << "reference #{reference["id"]}.segments[#{index}].#{field}: positive integer required" unless segment[field].is_a?(Integer) && segment[field].positive? }
    if segment["verse_start"].is_a?(Integer) && segment["verse_end"].is_a?(Integer) && segment["verse_end"] < segment["verse_start"]
      errors << "reference #{reference["id"]}.segments[#{index}]: verse_end precedes verse_start"
    end
  end
end

check_refs = lambda do |owner, ids|
  ids.to_a.each { |id| errors << "#{owner}: unknown scripture reference #{id}" unless reference_ids.include?(id) }
end
check_entities = lambda do |owner, ids|
  ids.to_a.compact.each { |id| errors << "#{owner}: unknown entity #{id}" unless entity_ids.include?(id) }
end
check_locations = lambda do |owner, ids|
  ids.to_a.compact.each { |id| errors << "#{owner}: unknown location #{id}" unless location_ids.include?(id) }
end

character = docs["character"] || {}
errors << "character.identity.entity_id must equal character_id" unless character.dig("identity", "entity_id") == character_id
check_entities.call("character identity", [character.dig("identity", "entity_id"), character.dig("identity", "nation_entity_id")])
check_entities.call("character leadership", [character.dig("leadership", "predecessor_entity_id"), character.dig("leadership", "named_successor_entity_id")])
check_refs.call("character calling", character.dig("leadership", "calling_reference_ids"))
check_locations.call("character locations", character["location_ids"])
check_locations.call("character burial", [character.dig("lifespan", "burial_location_id")])
check_refs.call("character death age", character.dig("lifespan", "death_age_reference_ids"))
character.dig("names", "aliases").to_a.each { |item| check_refs.call("alias #{item["id"]}", item["reference_ids"]) }
character.dig("titles", "scriptural_descriptors").to_a.each { |item| check_refs.call("descriptor #{item["descriptor"]}", item["reference_ids"]) }
(character["virtues"].to_a + character["failures_and_limits"].to_a).each { |item| check_refs.call("claim #{item["id"]}", item["reference_ids"]) }

relationships = docs.dig("relationships", "relationships").to_a
unique_index.call(relationships, "id", "relationships", relationship_pattern)
relationships.each do |relationship|
  check_entities.call("relationship #{relationship["id"]}", [relationship["target_entity_id"]])
  check_refs.call("relationship #{relationship["id"]}", relationship["reference_ids"])
  errors << "relationship #{relationship["id"]}: invalid direction" unless %w[outgoing incoming bidirectional].include?(relationship["direction"])
end

events = docs.dig("timeline", "events").to_a
event_ids = unique_index.call(events, "event_id", "timeline events", event_pattern)
sequences = events.map { |event| event["sequence"] }
errors << "timeline events: sequence values must be unique" unless sequences.uniq.length == sequences.length
errors << "timeline events: must be sorted by sequence" unless sequences.all? { |value| value.is_a?(Integer) } && sequences == sequences.sort
events.each do |event|
  check_refs.call("event #{event["event_id"]}", event["reference_ids"])
  check_entities.call("event #{event["event_id"]}", event["participant_entity_ids"])
  check_locations.call("event #{event["event_id"]}", event["location_ids"])
  errors << "event #{event["event_id"]}: Joshua must be a participant" unless event["participant_entity_ids"].to_a.include?(character_id)
end

symbol_uses = docs.dig("symbols", "symbol_uses").to_a
used_symbol_ids = unique_index.call(symbol_uses, "symbol_id", "symbol uses")
used_symbol_ids.each { |id| errors << "symbol uses: unknown symbol #{id}" unless symbol_ids.include?(id) }
symbol_uses.each { |use| check_refs.call("symbol #{use["symbol_id"]}", use["reference_ids"]) }
negative_ids = unique_index.call(docs.dig("symbols", "prohibited_visual_concepts"), "id", "prohibited concepts")

art = docs["art"] || {}
check_entities.call("art supporting entities", art.dig("scene", "supporting_entity_ids"))
check_locations.call("art scene", [art.dig("scene", "location_id")])
check_locations.call("art approved environments", art.dig("continuity", "approved_environment_location_ids"))
art.dig("scene", "required_symbol_ids").to_a.each { |id| errors << "art required symbols: unused or unknown symbol #{id}" unless used_symbol_ids.include?(id) }
art["negative_concept_ids"].to_a.each { |id| errors << "art negative concepts: unknown concept #{id}" unless negative_ids.include?(id) }
scene_event = art.dig("scene", "narrative_event_id")
errors << "art.scene.narrative_event_id: unknown event #{scene_event}" unless event_ids.include?(scene_event)
weapon_policy = art.dig("weapon", "validation_policy") || "exact"
weapon_count = art.dig("weapon", "count")
constraints = art.dig("constraints", "weapon_count") || {}
if weapon_policy == "exact" && !weapon_count.is_a?(Integer)
  errors << "art.weapon.count: exact policy requires an integer count"
end
errors << "art.weapon.count: below declared minimum" if constraints["minimum"] && weapon_count.to_i < constraints["minimum"]
errors << "art.weapon.count: above declared maximum" if constraints["maximum"] && weapon_count.to_i > constraints["maximum"]

(gameplay = docs["gameplay"] || {}).dig("preferred_mechanics").to_a.each { |mechanic| check_refs.call("mechanic #{mechanic["id"]}", mechanic["rationale_reference_ids"]) }
gameplay.dig("differentiation").to_a.each { |item| check_entities.call("gameplay differentiation", [item["other_character_id"]]) }
check_refs.call("signature ability", gameplay.dig("signature_ability", "rationale_reference_ids"))

profiles = {"character" => character, "references" => docs["references"], "timeline" => docs["timeline"], "relationships" => docs["relationships"], "symbols" => docs["symbols"], "gameplay" => gameplay, "art" => art, "prompt" => docs["prompt"]}
resolve_path = lambda do |path|
  head, *parts = path.split(".")
  value = profiles[head]
  parts.each { |part| value = value.is_a?(Hash) ? value[part] : nil }
  value
end
docs.dig("prompt", "semantic_components").to_h.each do |component, spec|
  spec["field_refs"].to_a.each { |path| errors << "prompt component #{component}: unresolved field_ref #{path}" if resolve_path.call(path).nil? }
end
aspect_ref = docs.dig("prompt", "output", "aspect_ratio_field_ref")
errors << "prompt.output.aspect_ratio_field_ref: unresolved #{aspect_ref}" if resolve_path.call(aspect_ref.to_s).nil?

# Validate the compiled prompt and every machine trace source against canonical fields.
prompt_profile = docs["prompt"] || {}
compiled_path = ROOT.join(prompt_profile.dig("compiled_artifact", "path").to_s)
trace_path = ROOT.join(prompt_profile.dig("compiled_artifact", "traceability_path").to_s)
if !compiled_path.file?
  errors << "prompt.compiled_artifact.path: file does not exist"
elsif !trace_path.file?
  errors << "prompt.compiled_artifact.traceability_path: file does not exist"
else
  trace = load_yaml.call(trace_path)
  prompt_bytes = compiled_path.binread
  errors << "prompt trace: compiled SHA-256 mismatch" unless trace["compiled_prompt_sha256"] == Digest::SHA256.hexdigest(prompt_bytes)
  prompt_sentences = prompt_bytes.strip.split(/\.\s+/).each_with_index.map { |part, index| index < prompt_bytes.strip.split(/\.\s+/).length - 1 ? "#{part}." : part }
  clauses = trace["clauses"].to_a
  errors << "prompt trace: clause count does not match prompt sentences" unless clauses.length == prompt_sentences.length
  clauses.each_with_index do |clause, index|
    sentence = prompt_sentences[index]
    errors << "prompt trace #{clause["id"]}: text does not match compiled sentence" unless clause["text"] == sentence
    errors << "prompt trace #{clause["id"]}: sentence SHA-256 mismatch" unless clause["text_sha256"] == Digest::SHA256.hexdigest(sentence.to_s)
    errors << "prompt trace #{clause["id"]}: at least one source required" if clause["sources"].to_a.empty?
    clause["sources"].to_a.each do |source|
      match = source.match(/\A(.+\.yaml):(.+)\z/)
      next unless match
      source_file = ROOT.join(match[1])
      if !source_file.file?
        errors << "prompt trace #{clause["id"]}: missing source file #{match[1]}"
        next
      end
      source_document = load_yaml.call(source_file)
      value = match[2].split(".").reduce(source_document) { |memo, part| memo.is_a?(Hash) ? memo[part] : nil }
      errors << "prompt trace #{clause["id"]}: unresolved canonical field #{source}" if value.nil?
    end
  end
  trace.dig("negative_prompt", "provenance").to_a.each do |source|
    match = source.match(/\A(.+\.yaml):(.+)\z/)
    next unless match
    source_file = ROOT.join(match[1])
    if !source_file.file?
      errors << "negative prompt trace: missing source file #{match[1]}"
      next
    end
    source_document = load_yaml.call(source_file)
    value = match[2].split(".").reduce(source_document) { |memo, part| memo.is_a?(Hash) ? memo[part] : nil }
    errors << "negative prompt trace: unresolved canonical field #{source}" if value.nil?
  end
end

# Compatibility YAML may only point at canonical documents; it may not restate facts.
manifest.dig("human_views", "compatibility_pointers").to_h.each do |relative, document_name|
  pointer_path = ROOT.join(relative)
  if !pointer_path.file?
    errors << "compatibility pointer #{relative}: file does not exist"
    next
  end
  pointer = load_yaml.call(pointer_path)
  expected = package_dir.join(manifest.dig("documents", document_name).to_s).relative_path_from(ROOT).to_s
  errors << "compatibility pointer #{relative}: canonical_source must be #{expected}" unless pointer["canonical_source"] == expected
  allowed = %w[schema_version document_type collector_id canonical_source canonical_knowledge_version projection_policy]
  extra = pointer.keys - allowed
  errors << "compatibility pointer #{relative}: duplicated fields #{extra.join(", ")}" unless extra.empty?
end

review = docs.dig("review", "review_state").to_h
review.each { |key, state| errors << "review_state.#{key}: invalid state #{state}" unless states.include?(state) }
generation_state = docs.dig("review", "generation_state", "state")
errors << "review.generation_state.state: invalid state #{generation_state}" unless states.include?(generation_state)

doc_root = ROOT.join(manifest.dig("human_views", "root").to_s)
manifest.dig("human_views", "projections").to_h.each do |filename, field_refs|
  errors << "human view #{filename}: file does not exist" unless doc_root.join(filename).file?
  field_refs.to_a.each { |path| errors << "human view #{filename}: unresolved projection #{path}" if resolve_path.call(path).nil? }
end

# Generation readiness is derived from evidence; a manually ready request cannot bypass gates.
gates = docs.dig("review", "gates").to_a
required_gate_ids = docs.dig("review", "generation_readiness", "required_gate_ids").to_a
blocking_gates = required_gate_ids.reject do |gate_id|
  gate = gates.find { |candidate| candidate["gate_id"] == gate_id }
  gate && gate["state"] == "approved" && gate["approvals"].to_a.any? && gate["open_findings"].to_a.none? { |finding| finding["blocking"] }
end
adapter_selected = docs.dig("review", "generation_readiness", "adapter_selected") == true
output_recorded = docs.dig("review", "generation_readiness", "output_settings_recorded") == true
computed_ready = blocking_gates.empty? && adapter_selected && output_recorded
if generation_state == "ready" && !computed_ready
  errors << "generation readiness: ready is inconsistent with review evidence (blocking gates: #{blocking_gates.join(', ')})"
end
puts "BLOCKED: #{manifest['collector_id']} artwork generation — required review gates or adapter settings pending" if errors.empty? && !computed_ready

if errors.empty?
  puts "PASS #{manifest["package_id"]}: #{docs.length} documents, #{reference_ids.length} references, #{events.length} events, #{relationships.length} relationships, #{used_symbol_ids.length} symbols"
  exit 0
end
warn "FAIL #{manifest["package_id"] || package_dir}: #{errors.length} error(s)"
errors.each { |error| warn "- #{error}" }
exit 1
