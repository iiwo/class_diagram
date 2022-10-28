# frozen_string_literal: true

module ClassDiagram
  class File
    attr_reader :path, :tree

    def initialize(path:)
      self.path = PathFinder.normalize(path)
    end

    def parse
      self.tree = Parser::Tree.new(ast_root_node: ast).build
      self
    end

    private

      attr_writer :path, :tree

      def ast
        @ast ||= parse_ast
      end

      def parse_ast
        raise "file doesn't exist" unless ::File.file?(path)

        ::Parser::CurrentRuby.parse(::File.read(path))
      end
  end
end
