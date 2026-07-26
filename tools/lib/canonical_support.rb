# frozen_string_literal: true
require "yaml"
require "json"
require "pathname"

module CanonicalSupport
  class LoadError < StandardError; end
  module_function

  def safe_yaml(path)
    value = YAML.safe_load_file(path.to_s, permitted_classes: [], permitted_symbols: [], aliases: false)
    unless value.is_a?(Hash)
      raise LoadError, "top-level YAML value must be a mapping"
    end
    value
  rescue Psych::Exception => e
    raise LoadError, "unsafe or malformed YAML: #{e.message}"
  end

  def package_dirs(root)
    root.join("knowledge/characters").glob("**/data/manifest.yaml").sort.map(&:dirname)
  end

  def assembled(package_dir)
    manifest = safe_yaml(package_dir.join("manifest.yaml"))
    manifest.fetch("documents").each_with_object({"manifest" => manifest}) do |(name, relative), result|
      result[name] = safe_yaml(package_dir.join(relative))
    end
  end

  # Deliberately implements the repository schema vocabulary rather than claiming
  # complete Draft 2020-12 support. Unsupported keywords are rejected explicitly.
  class SchemaValidator
    SUPPORTED = %w[$schema $id $ref $defs title description type required properties additionalProperties items enum const pattern minLength minimum minItems maxItems uniqueItems anyOf oneOf allOf].freeze
    Error = Data.define(:path, :rule, :value, :message)

    def initialize(schema)
      @root = schema
      unknown = keyword_nodes(schema).flat_map { |node| node.keys.select { |key| key.start_with?("$") && !SUPPORTED.include?(key) } }.uniq
      raise ArgumentError, "unsupported schema keyword(s): #{unknown.join(', ')}" unless unknown.empty?
    end

    def validate(value)
      errors = []
      visit(@root, value, [], errors)
      errors
    end

    private

    def keyword_nodes(value)
      return [] unless value.is_a?(Hash)
      [value] + value.values.flat_map { |child| child.is_a?(Hash) ? keyword_nodes(child) : child.is_a?(Array) ? child.flat_map { |v| keyword_nodes(v) } : [] }
    end

    def visit(schema, value, path, errors)
      if schema["$ref"]
        target = schema["$ref"].delete_prefix("#/").split("/").reduce(@root) { |memo, key| memo.fetch(key.gsub("~1", "/").gsub("~0", "~")) }
        return visit(target, value, path, errors)
      end
      schema.fetch("allOf", []).each { |part| visit(part, value, path, errors) }
      validate_combinator("anyOf", schema, value, path, errors) if schema["anyOf"]
      validate_combinator("oneOf", schema, value, path, errors) if schema["oneOf"]
      type = schema["type"]
      unless type.nil? || type_match?(type, value)
        return add(errors, path, "type", value, "expected #{Array(type).join(' or ')}, received #{ruby_type(value)}")
      end
      add(errors, path, "enum", value, "value #{value.inspect} is not in the allowed enum") if schema["enum"] && !schema["enum"].include?(value)
      add(errors, path, "const", value, "expected #{schema['const'].inspect}") if schema.key?("const") && value != schema["const"]
      if value.is_a?(Hash)
        schema.fetch("required", []).each { |key| add(errors, path + [key], "required", nil, "required property is missing") unless value.key?(key) }
        properties = schema.fetch("properties", {})
        value.each { |key, child| visit(properties[key], child, path + [key], errors) if properties[key] }
        if schema["additionalProperties"] == false
          (value.keys - properties.keys).each { |key| add(errors, path + [key], "additionalProperties", value[key], "property is not allowed") }
        elsif schema["additionalProperties"].is_a?(Hash)
          (value.keys - properties.keys).each { |key| visit(schema["additionalProperties"], value[key], path + [key], errors) }
        end
      elsif value.is_a?(Array)
        add(errors, path, "minItems", value, "expected at least #{schema['minItems']} items") if schema["minItems"] && value.length < schema["minItems"]
        add(errors, path, "maxItems", value, "expected at most #{schema['maxItems']} items") if schema["maxItems"] && value.length > schema["maxItems"]
        add(errors, path, "uniqueItems", value, "items must be unique") if schema["uniqueItems"] && value.uniq.length != value.length
        value.each_with_index { |child, index| visit(schema["items"], child, path + [index], errors) } if schema["items"]
      elsif value.is_a?(String)
        add(errors, path, "minLength", value, "expected at least #{schema['minLength']} characters") if schema["minLength"] && value.length < schema["minLength"]
        add(errors, path, "pattern", value, "does not match #{schema['pattern']}") if schema["pattern"] && !Regexp.new(schema["pattern"]).match?(value)
      elsif value.is_a?(Numeric)
        add(errors, path, "minimum", value, "expected at least #{schema['minimum']}") if schema["minimum"] && value < schema["minimum"]
      end
    end

    def validate_combinator(name, schema, value, path, errors)
      matches = schema[name].count { |candidate| temporary = []; visit(candidate, value, path, temporary); temporary.empty? }
      valid = name == "anyOf" ? matches.positive? : matches == 1
      add(errors, path, name, value, "must match #{name == 'anyOf' ? 'at least one' : 'exactly one'} schema") unless valid
    end

    def type_match?(types, value)
      Array(types).any? { |type| {"object" => Hash, "array" => Array, "string" => String, "integer" => Integer, "number" => Numeric, "boolean" => [TrueClass, FalseClass], "null" => NilClass}[type].then { |klass| Array(klass).any? { |k| value.is_a?(k) } } }
    end

    def ruby_type(value) = value.nil? ? "null" : value.class.name.downcase
    def add(errors, path, rule, value, message) = errors << Error.new(path.map { |part| part.is_a?(Integer) ? "[#{part}]" : part }.join(".").gsub(".[", "["), rule, value, message)
  end
end
