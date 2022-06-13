namespace :class_diagram do
  desc 'Generate a class dependency diagram from a given path'
  task :diagram, [:class_file_path, :output_type, :format_name, :export_path] => :environment do |_task, args|
    class_file_path = args.class_file_path
    output_type = args.output_type || 'console'
    format_name = args.format_name || 'text'
    export_path = args.export_path

    def output(output_type:, export_path:)
      output_options = export_path ? { path: export_path } : {}

      case output_type
      when 'console'
        ClassDiagram::Outputs::Console.new(output_options)
      when 'file'
        ClassDiagram::Outputs::File.new(output_options)
      else
        raise 'output needs to be one of: [console, file]'
      end
    end

    def formatter(format_name:)
      case format_name
      when 'text'
        ClassDiagram::Formatters::Text.new
      when 'html'
        ClassDiagram::Formatters::HTML.new
      else
        raise 'output needs to be one of: [text, html]'
      end
    end

    ClassDiagram.diagram(
      path: class_file_path,
      output: output(output_type: output_type, export_path: export_path),
      formatter: formatter(format_name: format_name)
    )
  end
end
