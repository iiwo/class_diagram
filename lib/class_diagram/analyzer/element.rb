# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    class Element
      attr_reader :source_path, :namespaced_names, :constantizer

      ELEMENTS = {
        const: 'Elements::ConstElement'
      }.freeze

      class << self
        def build(key:, namespaced_names: [], constantizer: nil, source_path: nil)
          return unless ELEMENTS.key?(key)

          eval(ELEMENTS[key]).new(
            namespaced_names: namespaced_names,
            source_path: source_path,
            constantizer: constantizer
          ).build
        end
      end

      def initialize(namespaced_names:, source_path:, constantizer:)
        self.namespaced_names = namespaced_names
        self.source_path = PathFinder.normalize(source_path)
        self.constantizer = constantizer
      end

      def build
        return if constantizer && !constantizer_result

        self
      end

      def to_h
        {
          name: name,
          type: type,
          path: path
        }
      end

      def name
        if constantizer
          constantizer_result[:name]
        else
          namespaced_names.last
        end
      end

      def path
        @path ||= extracted_path
      end

      private

        attr_writer :source_path, :namespaced_names, :constantizer

        def constantizer_result
          @constantizer_result ||= constantizer.find(namespaced_names: namespaced_names)
        end

        def extracted_path
          if constantizer
            constantizer_result[:path]
          else
            source_path
          end
        end
    end
  end
end
