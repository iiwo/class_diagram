# frozen_string_literal: true

module ClassDiagram
  module Constantizers
    class Project
      def initialize(project:)
        self.project = project
      end

      def find(namespaced_names:)
        item = nil

        namespaced_names.each do |name|
          project.members.each do |member|
            if member[:name] == name
              item = member
              break
            end
          end
          break if item
        end

        item&.slice(:name, :path)
      end

      private

        attr_accessor :project
    end
  end
end
