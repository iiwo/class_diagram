# frozen_string_literal: true

module ClassDiagram
  module Outputs
    class File
      def initialize(exporter:, options: { path: './diagram.txt' })
        @exporter = exporter
        @options = options
      end

      def save
        ::File.write(path, @exporter.export)
      end

      private

        def path
          @options[:path]
        end
    end
  end
end
