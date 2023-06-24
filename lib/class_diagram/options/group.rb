# frozen_string_literal: true

module ClassDiagram
  module Options
    class Group
      DEFAULTS = {
        scope: [
          {
            './**/*.rb': { follow: true, max_depth: Include::MAX_DEPTH }
          }
        ],
        include: [
          {
            './**/*.rb': { follow: true, max_depth: Include::MAX_DEPTH }
          }
        ],
        exclude: []
      }.freeze

      attr_reader :includes, :excludes, :scopes, :diagram

      def initialize(options_hash: DEFAULTS)
        self.options_hash = options_hash

        self.includes = (self.options_hash[:include] || []).map do |include_hash|
          Include.new(options_hash: include_hash)
        end
        self.excludes = (self.options_hash[:exclude] || []).map do |include_hash|
          Exclude.new(options_hash: include_hash)
        end
        self.scopes = (self.options_hash[:scope] || []).map do |scope_hash|
          Include.new(options_hash: scope_hash)
        end
        self.diagram = Diagram.new(options_hash: self.options_hash[:diagram] || {})
      end

      def include?(path:)
        match_include?(path: path) && !match_exclude?(path: path)
      end

      def follow?(path:, depth: 0)
        last_include = match_includes(path: path).last

        last_include.follow? && depth <= last_include.max_depth
      end

      def to_h
        options_hash
      end

      private

        attr_accessor :options_hash
        attr_writer :includes, :excludes, :scopes, :diagram

        def match_include?(path:)
          match_includes(path: path).any?
        end

        def match_exclude?(path:)
          excludes.any? { |exclude| exclude.match?(path: path) }
        end

        def match_includes(path:)
          includes.grep(path: path)
        end
    end
  end
end
