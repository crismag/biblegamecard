# frozen_string_literal: true

require "json"
require "open3"
require "pathname"
require "tmpdir"
require "test/unit"

class LegendaryPromptDevelopmentToolsTest < Test::Unit::TestCase
  ROOT = Pathname.new(__dir__).parent.expand_path

  def run_ruby(*args)
    Open3.capture3(RbConfig.ruby, *args, chdir: ROOT.to_s)
  end

  def test_validator_rejects_missing_argument
    _stdout, _stderr, status = run_ruby("tools/validate_legendary_prompt_development.rb")
    assert_equal 2, status.exitstatus
  end

  def test_report_outputs_valid_json_with_zero_or_more_profiles
    stdout, stderr, status = run_ruby("tools/report_legendary_generation_readiness.rb")
    assert status.success?, stderr
    report = JSON.parse(stdout)
    assert_equal "0.1.0", report.fetch("schema_version")
    assert_kind_of Integer, report.fetch("profile_count")
    assert_kind_of Array, report.fetch("profiles")
  end

  def test_prompt_tracker_has_every_legendary_collector_id_once
    tracker = JSON.parse(ROOT.join("registry/legendary_prompt_development.json").read)
    ids = tracker.fetch("characters").map { |item| item.fetch("collector_id") }
    assert_equal (1..34).map { |number| format("L%03d", number) }, ids
    assert_equal ids.length, ids.uniq.length
  end
end
