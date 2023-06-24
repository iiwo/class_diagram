# frozen_string_literal: true

module ClassDiagram
  module Parser
    class Tree
      def initialize(ast_root_node:)
        self.ast_root_node = ast_root_node
      end

      def build
        self.nodes ||= process
        self
      end

      def to_h
        nodes.map(&:to_h)
      end

      private

        attr_accessor :ast_root_node, :nodes

        def process(current_node: ast_root_node, depth: 0, parent: nil, nodes: [])
          node = Node.for(ast_node: current_node, parent: parent)
          parent_node = parent

          if node.include?
            parent_node = node

            if parent
              parent.children << node
            else
              # root nodes
              nodes << node
            end
          end

          (current_node&.children || []).each do |child_node|
            next unless child_node.is_a?(::Parser::AST::Node)

            process(current_node: child_node, depth: depth + 1, parent: parent_node, nodes: nodes)
          end

          nodes
        end
    end
  end
end
