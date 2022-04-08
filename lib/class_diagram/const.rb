# frozen_string_literal: true

module ClassDiagram
  # a wrapper for Parser::AST::Node Const
  # adding capability to identify const type and location
  class Const
    def self.wrap(node)
      node.children.map do |child|
        child.is_a?(Parser::AST::Node) ? Const.wrap(child) : child
      end.flatten.compact.join('::')
    end

    def initialize(name:)
      @name = name.to_s
    end

    def project?
      exist? && location.project?
    end

    def exist?
      !!object
    end

    def class?
      object.is_a?(Class)
    end

    def module?
      object.is_a?(Module)
    end

    def location
      exist? && Location.new(path: const_sauce_path(parsed_name))
    end

    def inherits_from?(class_name)
      object.ancestors.map(&:to_s).include?(class_name.to_s)
    end

    attr_reader :name

    def parsed_name
      if class? || module?
        object.name
      else
        filtered_name
      end
    end

    private

      def object
        @name.safe_constantize # additionally needed to preload const
      end

      def filtered_name
        # remove double colon prefix
        @name.gsub(/(^:*)/, '')
      end

      def const_sauce_path(const)
        Module.const_source_location(const)&.first
      end
  end
end
