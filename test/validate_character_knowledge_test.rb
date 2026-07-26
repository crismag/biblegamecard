# frozen_string_literal: true
require "test/unit"
require "tmpdir"
require "fileutils"
require "yaml"
require "open3"

class ValidateCharacterKnowledgeTest < Test::Unit::TestCase
  ROOT = File.expand_path("..", __dir__)
  SOURCE = File.join(ROOT, "knowledge/characters/legendary/L010_joshua/data")
  TOOL = File.join(ROOT, "tools/validate_character_knowledge.rb")

  def run_validator(path)
    Open3.capture3(RbConfig.ruby, TOOL, path).then { |out, err, status| [status.exitstatus, out + err] }
  end

  def with_package
    Dir.mktmpdir("canonical-package") do |dir|
      package = File.join(dir, "data")
      FileUtils.cp_r(SOURCE, package)
      edit(package, "manifest.yaml") { |v| v["human_views"]["compatibility_pointers"] = {} }
      yield package
    end
  end

  def edit(package, file)
    path = File.join(package, file)
    value = YAML.safe_load_file(path, aliases: false)
    yield value
    File.write(path, YAML.dump(value))
  end

  def assert_invalid(message)
    with_package do |package|
      yield package
      code, output = run_validator(package)
      assert_equal 1, code, output
      assert_include output, message
    end
  end

  def test_joshua_passes
    code, output = run_validator(SOURCE)
    assert_equal 0, code, output
    assert_include output, "PASS L010_JOSHUA_CANONICAL_KNOWLEDGE"
    assert_include output, "BLOCKED: L010 artwork generation"
  end

  def test_missing_required_schema_field_fails
    assert_invalid("required property is missing") { |p| edit(p, "gameplay.yaml") { |v| v.delete("archetype") } }
  end

  def test_wrong_schema_type_fails
    assert_invalid("expected integer, received string") { |p| edit(p, "timeline.yaml") { |v| v["events"][0]["sequence"] = "ten" } }
  end

  def test_unknown_entity_fails
    assert_invalid("unknown entity UNKNOWN_PERSON") { |p| edit(p, "relationships.yaml") { |v| v["relationships"][0]["target_entity_id"] = "UNKNOWN_PERSON" } }
  end

  def test_unknown_location_fails
    assert_invalid("unknown location UNKNOWN_PLACE") { |p| edit(p, "timeline.yaml") { |v| v["events"][0]["location_ids"] = ["UNKNOWN_PLACE"] } }
  end

  def test_unknown_scripture_reference_fails
    assert_invalid("unknown scripture reference REF_UNKNOWN") { |p| edit(p, "timeline.yaml") { |v| v["events"][0]["reference_ids"] = ["REF_UNKNOWN"] } }
  end

  def test_duplicate_event_id_fails
    assert_invalid("duplicate ID") { |p| edit(p, "timeline.yaml") { |v| v["events"][1]["event_id"] = v["events"][0]["event_id"] } }
  end

  def test_unsorted_timeline_fails
    assert_invalid("must be sorted by sequence") { |p| edit(p, "timeline.yaml") { |v| v["events"][0], v["events"][1] = v["events"][1], v["events"][0] } }
  end

  def test_invalid_prompt_field_reference_fails
    assert_invalid("unresolved field_ref") { |p| edit(p, "prompt.yaml") { |v| v["semantic_components"]["subject"]["field_refs"] = ["character.not_real"] } }
  end

  def test_compiled_prompt_hash_mismatch_fails
    assert_invalid("compiled SHA-256 mismatch") do |p|
      trace = File.join(ROOT, "generated/prompts/L010-JOSHUA-ART-01/1.0.0/prompt_traceability.yaml")
      backup = File.binread(trace)
      begin
        parsed = YAML.safe_load(backup, aliases: false); parsed["compiled_prompt_sha256"] = "0" * 64; File.write(trace, YAML.dump(parsed))
        code, output = run_validator(p); assert_equal 1, code, output; assert_include output, "compiled SHA-256 mismatch"
      ensure
        File.binwrite(trace, backup)
      end
      return
    end
  end

  def test_pointer_with_copied_facts_fails
    assert_invalid("duplicated fields") do |p|
      edit(p, "manifest.yaml") { |v| v["human_views"]["compatibility_pointers"] = {"test/fixtures/copied_pointer.yaml" => "character"} }
    end
  end

  def test_invalid_review_state_fails
    assert_invalid("invalid state impossible") { |p| edit(p, "review.yaml") { |v| v["review_state"]["art"] = "impossible" } }
  end

  def test_unsafe_yaml_fails_safely
    code, output = run_validator(File.join(ROOT, "test/fixtures/canonical_character_packages/unsafe_yaml"))
    assert_equal 1, code
    assert_include output, "unsafe or malformed YAML"
    assert_not_include output, "tools/validate_character_knowledge.rb:"
  end

  def test_non_joshua_identity_is_package_neutral
    with_package do |p|
      edit(p, "manifest.yaml") { |v| v["character_id"] = "MOSES"; v["package_id"] = "TEST_MOSES_PACKAGE" }
      %w[character references timeline relationships symbols gameplay art prompt review version_history].each { |f| edit(p, "#{f}.yaml") { |v| v["character_id"] = "MOSES" } }
      edit(p, "character.yaml") { |v| v["identity"]["entity_id"] = "MOSES" }
      edit(p, "timeline.yaml") { |v| v["events"].each { |event| event["participant_entity_ids"] = event["participant_entity_ids"].map { |id| id == "JOSHUA_SON_OF_NUN" ? "MOSES" : id }.uniq } }
      code, output = run_validator(p)
      assert_equal 0, code, output
      assert_include output, "PASS TEST_MOSES_PACKAGE"
    end
  end

  def test_zero_weapon_profile_can_pass
    with_package do |p|
      edit(p, "art.yaml") { |v| v["weapon"]["count"] = 0; v["weapon"]["type"] = "none" }
      code, output = run_validator(p)
      assert_equal 0, code, output
    end
  end
end
