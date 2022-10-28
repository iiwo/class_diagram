# frozen_string_literal: true

module ClassDiagram
  module Parser
    module Nodes
      class OtherNode < Node
        def include?
          false
        end
      end
    end
  end
end
