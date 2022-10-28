# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    module Members
      class ModuleMember < Member
        def type
          :module
        end
      end
    end
  end
end
