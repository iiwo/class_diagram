# frozen_string_literal: true

module ClassDiagram
  module Options
    class Diagram
      DEFAULTS = {
        format: { type: 'text' },
        output: { type: 'console' },
        filters: { orphans: false }
      }.freeze

      attr_reader :options_hash

      def initialize(options_hash: DEFAULTS)
        self.options_hash = DEFAULTS.merge(options_hash)
      end

      def format
        options_hash[:format]
      end

      def output
        options_hash[:output]
      end

      def filters
        options_hash[:filters]
      end

      private

        attr_writer :options_hash
    end
  end
end
