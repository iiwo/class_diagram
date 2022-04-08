# frozen_string_literal: true

module ClassDiagram
  module Exporters
    class Node
      def initialize(tree_node:)
        @tree_node = tree_node
      end

      def export
        from_name = @tree_node.name

        @tree_node.children.uniq(&:parsed_name).map.each do |const|
          "    #{from_name} --> #{to_name(const: const)}"
        end.join("\n")
      end

      private

        def to_name(const:) # @TODO: move to config, hardcoded for testing
          if const.inherits_from?('ActiveRecord::Base')
            "#{const.parsed_name}(fa:fa-database #{const.parsed_name})"
          elsif const.location.path.include?('app/jobs')
            "#{const.parsed_name}(fa:fa-dolly #{const.parsed_name})"
          else
            const.parsed_name
          end
        end
    end
  end
end
