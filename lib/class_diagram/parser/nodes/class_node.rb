# frozen_string_literal: true

module ClassDiagram
  module Parser
    module Nodes
      class ClassNode < Node
        def include?
          true
        end

        def namespace?
          true
        end

        def name
          children.first&.name
        end

        def key
          :class
        end

        def to_h
          {
            key: key,
            name: name,
            namespaces: namespaces,
            children: children.reject { |node| node == const_children.first }.map(&:to_h)
          }
        end

        private

          def const_children
            children.reject(&:namespace?)
          end
      end
    end
  end
end
