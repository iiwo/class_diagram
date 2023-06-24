# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    class Config
      def initialize(options:)
        self.options = options
      end

      def include?
        matched_includes.any?
      end

      def exclude?
        excludes.any? { |include| include.match?(path: path) }
      end

      def follow?
        matched_includes.all?(&:follow)
      end

      private

        attr_accessor :options

        def matched_includes
          @matched_includes ||= includes.grep(path: path)
        end
    end
  end
end
