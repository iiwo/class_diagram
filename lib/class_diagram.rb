# frozen_string_literal: true

require 'parser/current'
require_relative 'class_diagram/version'
require_relative 'class_diagram/location'
require_relative 'class_diagram/const'
require_relative 'class_diagram/const_node'
require_relative 'class_diagram/mapper'
require_relative 'class_diagram/tree'
require_relative 'class_diagram/tree_node'
require_relative 'class_diagram/outputs/console'
require_relative 'class_diagram/outputs/file'
require_relative 'class_diagram/formatters/text'
require_relative 'class_diagram/formatters/html'
require_relative 'class_diagram/exporters/mermaid/node'
require_relative 'class_diagram/exporters/mermaid/diagram'
require 'class_diagram/railtie' if defined?(Rails)

module ClassDiagram
  def self.diagram(
    path:,
    exporter: Exporters::Mermaid::Diagram,
    formatter: Formatters::Text.new,
    output: Outputs::Console.new
  )
    tree = Tree.new(path: path)
    output.save(diagram_data: exporter.new(tree: tree).export, formatter: formatter)
  end
end
