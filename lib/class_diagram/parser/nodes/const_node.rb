# frozen_string_literal: true

module ClassDiagram
  module Parser
    module Nodes
      class ConstNode < Node
        def name(item: node, names: [])
          return if item.nil?

          if item.is_a?(Symbol)
            names << item
          else
            item.children.each do |child|
              name(item: child, names: names)
            end
          end
          names.join('::')
        end

        def key
          :const
        end

        def namespace?
          children.first&.namespace? || false
        end

        def to_h
          {
            key: key,
            name: name,
            namespaces: namespaces,
            namespaced_names: namespaced_names
          }
        end
      end
    end
  end
end
