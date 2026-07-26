#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"
require "json"
require "pathname"

root = Pathname.new(__dir__).parent.expand_path
package_dir = Pathname.new(ARGV[0] || "knowledge/characters/legendary/L010_joshua/data")
package_dir = root.join(package_dir) unless package_dir.absolute?
manifest = YAML.unsafe_load_file(package_dir.join("manifest.yaml").to_s)
assembled = {"manifest" => manifest}
manifest.fetch("documents").each do |name, relative|
  assembled[name] = YAML.unsafe_load_file(package_dir.join(relative).to_s)
end
puts JSON.pretty_generate(assembled)
