#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "pathname"
require "yaml"
require_relative "lib/canonical_support"

ROOT = Pathname.new(__dir__).parent.expand_path
PROFILE_DIR = ROOT.join("knowledge/prompt_development/legendary")
SCHEMA_PATH = ROOT.join("schemas/legendary_prompt_development.schema.json")
USAGE = "Usage: ruby tools/validate_legendary_prompt_development.rb [--all|PROFILE.yaml]"

paths = if ARGV == ["--all"]
          PROFILE_DIR.glob("L[0-9][0-9][0-9]_*.yaml").sort
        elsif ARGV.length == 1
          [ROOT.join(ARGV.first)]
        else
          warn USAGE
          exit 2
        end

if paths.empty?
  warn "No Legendary prompt-development profiles found"
  exit 2
end

schema = JSON.parse(SCHEMA_PATH.read)
validator = CanonicalSupport::SchemaValidator.new(schema)
failures = 0
seen_ids = {}

paths.each do |path|
  errors = []
  begin
    profile = CanonicalSupport.safe_yaml(path)
    validator.validate(profile).each do |violation|
      errors << "Schema #{violation.path}: #{violation.message} (rule #{violation.rule})"
    end

    collector_id = profile["collector_id"]
    expected_prefix = path.basename.to_s.split("_").first
    errors << "collector_id #{collector_id.inspect} does not match filename #{expected_prefix}" unless collector_id == expected_prefix
    errors << "duplicate collector_id #{collector_id}" if seen_ids.key?(collector_id)
    seen_ids[collector_id] = path

    readiness = profile.fetch("readiness", {})
    if readiness["content_state"] == "GENERATION_READY_DRAFT"
      errors << "positive prompt is empty" if profile.dig("prompt_source", "positive_prompt").to_s.strip.empty?
      errors << "negative prompt is empty" if profile.dig("prompt_source", "negative_prompt").to_s.strip.empty?
      errors << "primary passages are empty" if profile.dig("biblical_basis", "primary_passages").to_a.empty?
      errors << "prompt traceability is empty" if profile.dig("traceability", "prompt_clauses").to_a.empty?
    end

    %w[theological_review historical_review gameplay_review].each do |gate|
      errors << "readiness.#{gate} must remain PENDING_HUMAN_REVIEW during this sprint" unless readiness[gate] == "PENDING_HUMAN_REVIEW"
    end
    errors << "readiness.artwork_generation must remain NOT_STARTED" unless readiness["artwork_generation"] == "NOT_STARTED"
  rescue StandardError => e
    errors << "load failed: #{e.message}"
  end

  if errors.empty?
    puts "PASS: #{path.relative_path_from(ROOT)}"
  else
    failures += 1
    warn "FAIL: #{path.relative_path_from(ROOT)}"
    errors.each { |error| warn "  - #{error}" }
  end
end

puts "#{failures.zero? ? 'PASS' : 'FAIL'}: #{paths.length} Legendary prompt-development profile(s) validated"
exit(failures.zero? ? 0 : 1)
