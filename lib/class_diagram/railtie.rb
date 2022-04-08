require 'rails'

module ClassDiagram
  class Railtie < Rails::Railtie
    railtie_name :class_diagram

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |file| load file }
    end
  end
end
