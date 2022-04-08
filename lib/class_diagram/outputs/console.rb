# frozen_string_literal: true

module ClassDiagram
  module Outputs
    class Console
      def initialize(exporter:, options: {})
        @exporter = exporter
        @options = options
      end

      def save
        puts @exporter.export
      end
    end
  end
end
