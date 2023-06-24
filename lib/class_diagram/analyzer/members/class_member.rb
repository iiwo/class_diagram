# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    module Members
      class ClassMember < Member
        def type
          :class
        end
      end
    end
  end
end
