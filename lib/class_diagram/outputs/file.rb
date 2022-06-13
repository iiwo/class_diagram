# frozen_string_literal: true

module ClassDiagram
  module Outputs
    class File
      def initialize(options = {})
        @options = options
      end

      def save(diagram_data:, formatter:)
        write_path = path || "./diagram.#{formatter.file_extension}"
        ::File.write(write_path, formatter.format(diagram_data: diagram_data))
      end

      private

        def path
          @options[:path]
        end
    end
  end
end
