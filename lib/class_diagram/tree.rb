# frozen_string_literal: true

module ClassDiagram
  # TreeNode collection built for a given path
  class Tree
    MAX_DEPTH = 20 # @TODO: move to configuration

    attr_reader :name

    def initialize(path:, name: '*', depth: 0, items: {})
      @path = path
      @items = items
      @depth = depth
      @name = name
    end

    # @return Array[<TreeNode>] an array of TreeNode items built for the given path
    def children
      @children ||= build
    end

    private

      attr_reader :items, :depth, :path

      def nodes(parent:)
        node = TreeNode.new(parent: parent, name: name)
        items[path] = node

        return items unless parent

        parent.children.compact.each do |child|
          child.namespaced_consts.each do |const|
            node.add(const)

            next if items[const.location.path]
            next if depth > MAX_DEPTH
            next if const.location.skip?

            items.merge(
              Tree.new(path: const.location.path, name: const.parsed_name, depth: depth + 1, items: items).children
            )
          end
        end

        items
      end

      def build
        nodes(parent: root)
      end

      def root
        return unless File.file?(path)

        node = Parser::CurrentRuby.parse(File.read(path))
        ClassDiagram::Mapper.new(node: node).extract
      end
  end
end
