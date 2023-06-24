# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[spec rubocop]

Dir.glob("#{Gem::Specification.find_by_name("class_diagram").gem_dir}/lib/class_diagram/tasks/**/*.rake").each do |file|
  import file
end
