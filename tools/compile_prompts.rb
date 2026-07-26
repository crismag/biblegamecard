#!/usr/bin/env ruby
# frozen_string_literal: true

require "optparse"
require_relative "lib/prompt_compilation"

options = {
  output: "generated/prompts",
  adapter: "openai",
  seed: 0,
  resolution: "1024x1536",
  check: false
}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: ruby tools/compile_prompts.rb (--profile PATH | --all) [options]"
  opts.on("--profile PATH", "Compile one prompt-development profile") { |value| options[:profile] = value }
  opts.on("--all", "Compile every registered profile") { options[:all] = true }
  opts.on("--output PATH", "Generated artifact root (default: generated/prompts)") { |value| options[:output] = value }
  opts.on("--adapter NAME", PromptCompilation::ADAPTERS.keys, "Model adapter") { |value| options[:adapter] = value }
  opts.on("--model NAME", "Provider model name") { |value| options[:model] = value }
  opts.on("--seed INTEGER", Integer, "Generation seed metadata") { |value| options[:seed] = value }
  opts.on("--resolution WIDTHxHEIGHT", /\A\d+x\d+\z/, "Output resolution metadata") { |value| options[:resolution] = value }
  opts.on("--check", "Fail if committed artifacts differ") { options[:check] = true }
end

begin
  parser.parse!
  raise OptionParser::MissingArgument, "choose exactly one of --profile or --all" unless !!options[:profile] ^ !!options[:all]
  root = File.expand_path("..", __dir__)
  profiles = if options[:all]
               registry = JSON.parse(File.read(File.join(root, "registry/legendary_prompt_development.json")))
               registry.fetch("characters").filter_map { |entry| entry["profile_path"] }
             else
               [options.fetch(:profile)]
             end
  compiler = PromptCompilation::Compiler.new(root: root)
  profiles.each do |profile|
    directory, files = compiler.compile(profile_path: profile, output_root: options[:output], adapter: options[:adapter], model: options[:model], seed: options[:seed], resolution: options[:resolution])
    compiler.write(directory, files, check: options[:check])
    puts "#{options[:check] ? 'verified' : 'compiled'} #{profile} -> #{directory.relative_path_from(Pathname(root))}"
  end
rescue OptionParser::ParseError, PromptCompilation::Error, KeyError, ArgumentError => e
  warn "prompt compiler: #{e.message}"
  warn parser
  exit 1
end
