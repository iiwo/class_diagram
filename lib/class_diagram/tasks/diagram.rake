# frozen_string_literal: true

namespace :class_diagram do
  desc 'Generate a class dependency diagram from a given path'
  task :diagram, [:config_path] do |_task, args|
    require 'class_diagram'

    config_path = args.config_path

    ClassDiagram.diagram(
      config_path: config_path
    )
  end
end
