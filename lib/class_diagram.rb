# frozen_string_literal: true

require 'parser/current'
require_relative 'class_diagram/version'
require_relative 'class_diagram/config_file'
require_relative 'class_diagram/path_finder'
require_relative 'class_diagram/logger'
require_relative 'class_diagram/formatters/text'
require_relative 'class_diagram/formatters/html'
require_relative 'class_diagram/outputs/console'
require_relative 'class_diagram/outputs/file'
require_relative 'class_diagram/exporters/mermaid/member'
require_relative 'class_diagram/exporters/mermaid/diagram'
require_relative 'class_diagram/exporters/export'
require_relative 'class_diagram/options/value'
require_relative 'class_diagram/options/include'
require_relative 'class_diagram/options/exclude'
require_relative 'class_diagram/options/diagram'
require_relative 'class_diagram/options/group'
require_relative 'class_diagram/options/project'
require_relative 'class_diagram/constatnizers/project'
require_relative 'class_diagram/parser/node'
require_relative 'class_diagram/parser/nodes/class_node'
require_relative 'class_diagram/parser/nodes/const_node'
require_relative 'class_diagram/parser/nodes/module_node'
require_relative 'class_diagram/parser/nodes/other_node'
require_relative 'class_diagram/parser/tree'
require_relative 'class_diagram/analyzer/project'
require_relative 'class_diagram/analyzer/group'
require_relative 'class_diagram/analyzer/file'
require_relative 'class_diagram/analyzer/member'
require_relative 'class_diagram/analyzer/members/class_member'
require_relative 'class_diagram/analyzer/members/module_member'
require_relative 'class_diagram/analyzer/element'
require_relative 'class_diagram/analyzer/elements/const_element'
require_relative 'class_diagram/file'
require 'class_diagram/railtie' if defined?(Rails)
require_relative 'class_diagram/class_diagram_cli'

module ClassDiagram
  def self.diagram(
    config_path: ClassDiagram::ConfigFile::DEFAULT_FILE_PATH
  )
    config = ClassDiagram::ConfigFile.new(file_path: config_path).load

    project = Analyzer::Project.new(
      options: ClassDiagram::Options::Project.new(options_hash: config.project)
    )
    project.build

    config.groups.each do |group_name, group_config|
      Logger.debug("processing group: #{group_name}")

      group = ClassDiagram::Analyzer::Group.new(
        project: project,
        options: ClassDiagram::Options::Group.new(options_hash: group_config)
      )
      group.build
      group.export
    end
  end
end
