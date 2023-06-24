# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    class File
      attr_reader :members

      def initialize(tree_hash:, source_path:, constantizer: nil, options: Options::Group.new)
        self.tree_hash = tree_hash
        self.source_path = PathFinder.normalize(source_path)
        self.constantizer = constantizer
        self.members = []
        self.options = options
      end

      def analyze(hash_nodes: [*tree_hash])
        return if hash_nodes.nil?

        hash_nodes.each do |hash_node|
          member = Member.build(
            **hash_node.slice(:key, :name, :namespaces, :children).merge(
              path: source_path,
              constantizer: constantizer,
              options: options
            )
          )
          members << member if member

          children = hash_node[:children]
          analyze(hash_nodes: children)
        end
        self
      end

      def to_h
        members.map(&:to_h)
      end

      private

        attr_accessor :tree_hash, :source_path, :constantizer, :options
        attr_writer :members, :options
    end
  end
end
