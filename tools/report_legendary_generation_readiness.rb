#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "pathname"
require_relative "lib/canonical_support"

ROOT = Pathname.new(__dir__).parent.expand_path
PROFILE_DIR = ROOT.join("knowledge/prompt_development/legendary")
OUTPUT_PATH = ROOT.join("generated/reports/legendary_generation_readiness.json")
WRITE = ARGV.delete("--write")
CHECK = ARGV.delete("--check")
abort "Usage: ruby tools/report_legendary_generation_readiness.rb [--write|--check]" unless ARGV.empty? && !(WRITE && CHECK)

required_paths = %w[
  identity.legendary_title identity.depicted_life_stage identity.era identity.culture
  biblical_basis.primary_passages biblical_basis.defining_scene
  gameplay_identity.archetype gameplay_identity.traits gameplay_identity.signature_ability gameplay_identity.strategic_identity
  visual_identity.presentation visual_identity.wardrobe visual_identity.signature_objects visual_identity.environment visual_identity.continuity_constraints
  composition.focal_action composition.pose composition.camera composition.card_frame_safe_space
  art_direction.mood art_direction.lighting art_direction.palette art_direction.rendering_language art_direction.prohibited_elements
  prompt_source.positive_prompt prompt_source.negative_prompt traceability.prompt_clauses
]

value_at = lambda do |record, path|
  path.split(".").reduce(record) { |value, key| value.is_a?(Hash) ? value[key] : nil }
end
blank = lambda { |value| value.nil? || (value.respond_to?(:empty?) && value.empty?) || (value.is_a?(String) && value.strip.empty?) }

profiles = PROFILE_DIR.glob("L[0-9][0-9][0-9]_*.yaml").sort.map do |path|
  profile = CanonicalSupport.safe_yaml(path)
  missing = required_paths.select { |field| blank.call(value_at.call(profile, field)) }
  unresolved = profile.dig("readiness", "unresolved_questions").to_a
  declared = profile.dig("readiness", "content_state")
  computed_ready = missing.empty? && declared == "GENERATION_READY_DRAFT"
  {
    "collector_id" => profile["collector_id"],
    "character_name" => profile["character_name"],
    "profile_path" => path.relative_path_from(ROOT).to_s,
    "declared_content_state" => declared,
    "computed_generation_ready" => computed_ready,
    "missing_required_fields" => missing,
    "unresolved_question_count" => unresolved.length,
    "deferred_reviews" => {
      "theological" => profile.dig("readiness", "theological_review"),
      "historical" => profile.dig("readiness", "historical_review"),
      "gameplay" => profile.dig("readiness", "gameplay_review")
    },
    "artwork_generation" => profile.dig("readiness", "artwork_generation")
  }
end

report = {
  "schema_version" => "0.1.0",
  "source_directory" => PROFILE_DIR.relative_path_from(ROOT).to_s,
  "profile_count" => profiles.length,
  "generation_ready_count" => profiles.count { |profile| profile["computed_generation_ready"] },
  "profiles" => profiles
}
rendered = JSON.pretty_generate(report) + "\n"

if CHECK
  abort "FAIL: readiness report missing; run with --write" unless OUTPUT_PATH.file?
  abort "FAIL: readiness report drift detected" unless OUTPUT_PATH.read == rendered
  puts "PASS: readiness report is current"
elsif WRITE
  OUTPUT_PATH.dirname.mkpath
  OUTPUT_PATH.write(rendered)
  puts "WROTE: #{OUTPUT_PATH.relative_path_from(ROOT)}"
else
  puts rendered
end
