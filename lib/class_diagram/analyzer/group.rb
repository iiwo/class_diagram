# frozen_string_literal: true

module ClassDiagram
  module Analyzer
    class Group
      attr_reader :members, :name

      def initialize(project:, options: Options::Group.new)
        self.file_paths = options.scopes.map(&:options_path)
        self.members = []
        self.project = project
        self.options = options
      end

      def build(paths: initial_paths, depth: 0)
        if depth.zero?
          Logger.debug("processing group with options: #{options.to_h}")
          Logger.debug("file paths: #{file_paths}")
        end

        self.processed_paths ||= []

        new_paths = process_paths(paths, depth: depth)

        if new_paths.any?
          Logger.debug("found #{new_paths.count} new references to analyze")
          build(paths: new_paths.uniq, depth: depth + 1)
        end

        self
      end

      def export
        Exporters::Export.new(
          group: self,
          options: options
        ).export
      end

      def to_h
        members.map(&:to_h)
      end

      private

        attr_writer :members, :name
        attr_accessor :file_paths, :project, :options, :processed_paths

        def process_paths(paths, depth:)
          paths.uniq.map do |path|
            Logger.debug("analyzing group file: #{path} at depth: #{depth}")

            processed_paths << path
            process_path(path, paths: paths, depth: depth)
          end.flatten
        end

        def process_path(path, paths:, depth:)
          parser_hash = ClassDiagram::File.new(path: path).parse.tree.to_h
          members = File.new(
            tree_hash: parser_hash,
            source_path: path,
            constantizer: constantizer,
            options: options
          ).analyze.members

          members.map { |member| process_member(member, paths: paths, depth: depth) }.flatten
        end

        def process_member(member, paths:, depth:)
          member_path = member.path

          return unless options.include?(path: member_path)

          members << member

          member.elements_paths.uniq.select do |element_path|
            !processed?(path: element_path) &&
              !paths.include?(element_path) &&
              options.follow?(path: element_path, depth: depth)
          end
        end

        def constantizer
          @constantizer ||= Constantizers::Project.new(project: project)
        end

        def processed?(path:)
          processed_paths.include?(path)
        end

        def initial_paths
          @initial_paths ||= file_paths.map { |path| PathFinder.glob(path) }.flatten.uniq
        end

        def members_paths
          members.map(&:path)
        end

        def members_names
          members.map(&:name)
        end
    end
  end
end
