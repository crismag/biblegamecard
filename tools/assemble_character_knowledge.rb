#!/usr/bin/env ruby
# frozen_string_literal: true
require "json"
require "pathname"
require "fileutils"
require_relative "lib/canonical_support"

ROOT = Pathname.new(__dir__).parent.expand_path
USAGE = "Usage: ruby tools/assemble_character_knowledge.rb [--check|--write] [--all|PACKAGE_DATA_DIR]"
if ARGV.delete("--help")
  puts USAGE
  exit 0
end
mode = ARGV.delete("--check") ? :check : ARGV.delete("--write") ? :write : :stdout
all = ARGV.delete("--all")
if all && !ARGV.empty? || !all && ARGV.length != 1
  warn USAGE
  exit 2
end
dirs = all ? CanonicalSupport.package_dirs(ROOT) : [Pathname.new(ARGV.first).then { |p| p.absolute? ? p : ROOT.join(p) }]
bad = 0
dirs.each do |dir|
  begin
    assembled = CanonicalSupport.assembled(dir)
    content = JSON.pretty_generate(assembled) + "\n"
    if mode == :stdout
      puts content
      next
    end
    destination = ROOT.join("generated/knowledge", assembled.dig("manifest", "package_id"), assembled.dig("manifest", "package_version"), "assembled.json")
    if mode == :write
      FileUtils.mkdir_p(destination.dirname)
      destination.write(content)
      puts "WROTE #{destination.relative_path_from(ROOT)}"
    elsif !destination.file? || destination.binread != content.b
      warn "STALE #{destination.relative_path_from(ROOT)}"
      bad += 1
    else
      puts "CURRENT #{destination.relative_path_from(ROOT)}"
    end
  rescue CanonicalSupport::LoadError, KeyError, Errno::ENOENT => e
    warn "FAIL #{dir}: #{e.message}"
    bad += 1
  end
end
if mode == :check
  puts "#{bad.zero? ? 'PASS' : 'FAIL'}: generated knowledge for #{dirs.length} package(s) #{bad.zero? ? 'is current' : 'has drift'}"
end
exit(bad.zero? ? 0 : 1)
