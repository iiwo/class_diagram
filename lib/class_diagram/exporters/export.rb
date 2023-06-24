# frozen_string_literal: true

module ClassDiagram
  module Exporters
    class Export
      def initialize(group:, options:)
        self.group = group
        self.options = options
      end

      def export
        exporter = ClassDiagram::Exporters::Mermaid::Diagram.new(members: group.to_h, options: options.diagram)
        data = exporter.export

        formatter_instance = formatter(format_type: options.diagram.format[:type])

        output_processor = output(
          output_type: options.diagram.output[:type],
          output_options: options.diagram.output
        )
        output_processor.save(diagram_data: data, formatter: formatter_instance)

        nil
      end

      private

        attr_accessor :group, :options

        def output(output_type:, output_options:)
          case output_type
          when 'console'
            ClassDiagram::Outputs::Console.new(output_options)
          when 'file'
            ClassDiagram::Outputs::File.new(output_options)
          else
            raise 'output needs to be one of: [console, file]'
          end
        end

        def formatter(format_type:)
          case format_type
          when 'text'
            ClassDiagram::Formatters::Text.new
          when 'html'
            ClassDiagram::Formatters::HTML.new
          else
            raise 'output needs to be one of: [text, html]'
          end
        end
    end
  end
end
