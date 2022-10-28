# frozen_string_literal: true
require 'yaml'

module ClassDiagram
  # Config  parser
  class ConfigFile
    DEFAULT_FILE_PATH = './.class_diagram.yml'

    def initialize(file_path: DEFAULT_FILE_PATH)
      self.file_path = file_path || DEFAULT_FILE_PATH
    end

    def load
      return {} unless exists?

      self.config = symbolize_recursive(load_yaml)
      self
    end

    def project
      config[:project]
    end

    def groups
      config[:groups]
    end

    private

      attr_accessor :config, :file_path

      def exists?
        ::File.exist?(file_path)
      end

      def load_yaml
        YAML.safe_load(
          ::File.read(file_path),
          permitted_classes: [Regexp, Symbol],
          permitted_symbols: [],
          aliases: true
        )
      end

      def symbolize_recursive(hash)
        {}.tap do |h|
          hash.each { |key, value| h[key.to_sym] = map_value(value) }
        end
      end

      def map_value(thing)
        case thing
        when Hash
          symbolize_recursive(thing)
        when Array
          thing.map { |v| map_value(v) }
        else
          thing
        end
      end
  end
end
