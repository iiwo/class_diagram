# frozen_string_literal: true

module A
  # class comment
  class B < ::A::C
    include F

    # method comment
    def initialize
      A::B::D.new
      A::C.new
    end
  end

  class C::D; end # rubocop:disable Style/ClassAndModuleChildren
end
