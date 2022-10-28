# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    class Member
      attr_reader :children, :elements, :name, :path

      MEMBERS = {
        class: 'Analyzer::Members::ClassMember',
        module: 'Analyzer::Members::ModuleMember'
      }.freeze

      class << self
        def build(
          key:,
          name:,
          namespaces:,
          path: nil,
          children: [],
          constantizer: nil,
          options: Options::Group.new
        )
          return unless MEMBERS.key?(key)

          eval(MEMBERS[key]).new(
            children: children,
            name: name,
            namespaces: namespaces,
            path: path,
            constantizer: constantizer,
            options: options
          ).build
        end
      end

      def initialize(children:, name:, namespaces:, path: nil, constantizer: nil, options: Options::Group.new)
        self.children = children || []
        self.path = path
        self.name = name
        self.namespaces = namespaces
        self.constantizer = constantizer
        self.elements = []
        self.options = options
      end

      def build
        children.each do |child_attributes|
          element = Element.build(
            **child_attributes.slice(
              :key, :namespaced_names
            ).merge(
              source_path: path,
              constantizer: constantizer
            )
          )
          elements << element if element && options.include?(path: element.path)
        end
        self
      end

      def to_h
        {
          name: namespaced_name,
          type: type,
          path: path,
          elements: elements.map(&:to_h)
        }
      end

      def elements_paths
        elements.map(&:path).flatten.compact.uniq
      end

      def namespaced_name
        (namespaces + [name]).join('::')
      end

      private

        attr_writer :children, :elements, :namespaces, :name, :constantizer, :path, :options
        attr_reader :options, :constantizer, :namespaces
    end
  end
end
