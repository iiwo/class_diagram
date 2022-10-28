# frozen_string_literal: true
require 'delegate'

module ClassDiagram
  module Parser
    class Node
      attr_accessor :children, :node, :parent

      def initialize(node, parent:)
        self.node = node
        self.parent = parent
        self.children = []
      end

      class << self
        def for(ast_node:, parent:)
          case ast_node&.type
          when :const
            Nodes::ConstNode.new(ast_node, parent: parent)
          when :class
            Nodes::ClassNode.new(ast_node, parent: parent)
          when :module
            Nodes::ModuleNode.new(ast_node, parent: parent)
          else
            Nodes::OtherNode.new(ast_node, parent: parent)
          end
        end
      end

      def namespace?
        false
      end

      def include?
        true
      end

      def ancestors
        return @ancestors if @ancestors

        @ancestors = []

        if parent
          @ancestors += [@parent]
          @ancestors += parent.ancestors
        end

        @ancestors
      end

      private

        def key
          self.class.name
        end

        def namespaces
          ancestors.select(&:namespace?).map(&:name).reverse
        end

        def namespaced_names
          names = (0..namespaces.count - 1).map { |i| namespaces[0..i].join('::') }.reverse + namespaces
          names.uniq.map { |namespace| [namespace, name].join('::') } + [name]
        end
    end
  end
end
