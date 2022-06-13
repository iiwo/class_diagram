# frozen_string_literal: true

module ClassDiagram
  module Outputs
    class Console
      def initialize(options)
        @options = options
      end

      def save(diagram_data:, formatter:)
        puts formatter.format(diagram_data: diagram_data)
      end
    end
  end
end
