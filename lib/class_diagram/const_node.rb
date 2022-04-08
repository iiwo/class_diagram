# frozen_string_literal: true

module ClassDiagram
  # Const tree node
  class ConstNode
    attr_accessor :node, :consts, :children, :parent

    MAX_DEPTH = 20

    def initialize(node:, parent:, consts: [], children: [])
      self.node = node
      self.consts = consts
      self.children = children
      self.parent = parent
    end

    def module?
      node.type == :module
    end

    def class?
      node.type == :class
    end

    def name
      consts.first&.children&.last
    end

    def namespaces
      up = self
      names = []
      index = 0

      while up && index < MAX_DEPTH
        names << up.name
        up = up.parent
        index += 1
      end

      names.reverse
    end

    def namespaced_consts
      consts_map.map do |const_arr|
        const_arr.find do |const_name|
          const = Const.new(name: const_name)
          const.project? && const.class? # || const.module?
        end
      end.compact.uniq.map do |const|
        Const.new(name: const)
      end
    end

    private

      def consts_map
        arr = []
        raw_consts.map do |const|
          const_arr = []
          const_arr << Const.wrap(const)
          sum = []
          namespaces.each do |namespace|
            sum << namespace
            const_arr << (sum + [Const.wrap(const)]).join('::')
          end
          arr << const_arr.reverse
        end
        arr
      end

      def raw_consts
        consts - [consts.first]
      end
  end
end
