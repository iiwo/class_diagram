require 'thor'

class ClassDiagramCLI < Thor
  desc 'diagram', 'Generate class diagram'
  method_option :config, aliases: '-c', desc: 'config file path'

  def diagram
    output = `bundle exec rake "class_diagram:diagram[#{options['config']}]"`
    print output
  end

  def self.exit_on_failure?
    true
  end
end
