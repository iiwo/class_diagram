# frozen_string_literal: true

module ClassDiagram
  class TreeNode
    attr_reader :parent, :children, :name

    def initialize(parent:, name:, children: [])
      @parent = parent
      @children = children
      @name = name
    end

    def add(child)
      @children << child
    end
  end
end
