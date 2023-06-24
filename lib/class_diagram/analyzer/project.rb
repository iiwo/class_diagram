# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    class Project
      attr_reader :members, :file_paths, :options

      def initialize(options: Options::Project.new)
        self.file_paths = options.scopes.map(&:options_path)
        self.members = []
        self.options = options
      end

      def build
        Logger.debug("processing project with options: #{options.to_h}")
        paths.each do |path|
          Logger.debug("analyzing project file: #{path}")

          parser_hash = ClassDiagram::File.new(path: path).parse.tree.to_h
          self.members += File.new(tree_hash: parser_hash, source_path: path, options: options).analyze.to_h
        end
      end

      def to_h
        members.map(&:to_h)
      end

      private

        attr_writer :members, :file_paths, :options

        def paths
          return @paths if @paths

          @paths = file_paths.map { |path| PathFinder.glob(path) }.flatten.uniq
        end
    end
  end
end
