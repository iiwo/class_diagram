# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    module Elements
      class ConstElement < Element
        def type
          :const
        end
      end
    end
  end
end
