# frozen_string_literal: true

module ClassDiagram
  # filters and maps Parser::AST::Node items to ConstNode objects
  class Mapper
    MAX_DEPTH = 10 # @TODO: move to configuration

    def initialize(node:, tree: nil, branch: nil, depth: 0)
      self.node = node
      self.tree = tree
      self.branch = branch
      self.depth = depth
    end

    # @return [ConstNode] root node for the const dependency tree
    def extract
      if %i[class module].include?(node.type)
        self.branch = ConstNode.new(node: node, parent: branch)

        if tree
          tree.children << branch
        else
          self.tree = branch
        end
      end

      process_children if branch && depth < MAX_DEPTH

      tree
    end

    private

      attr_accessor :node, :branch, :tree, :depth

      def process_children
        node.children.each do |child|
          next unless child.is_a?(Parser::AST::Node)

          branch.consts << child if child.type == :const

          ClassDiagram::Mapper.new(
            node: child,
            branch: branch,
            tree: tree,
            depth: depth + 1
          ).extract
        end
      end
  end
end
