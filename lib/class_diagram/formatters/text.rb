# frozen_string_literal: true

module ClassDiagram
  module Formatters
    class Text
      def initialize(options: {})
        @options = options
      end

      def format(diagram_data:)
        diagram_data
      end

      def file_extension
        'txt'
      end
    end
  end
end
