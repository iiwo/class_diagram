# frozen_string_literal: true

module ClassDiagram
  module Exporters
    module Mermaid
      class Diagram
        def initialize(tree:)
          @tree = tree
        end

        def export
          rows = ['graph TB'] + @tree.children.values.map do |tree_node|
            Node.new(tree_node: tree_node).export
          end.compact
          rows.join("\n").gsub(/[\n]+/, "\n")
        end
      end
    end
  end
end
