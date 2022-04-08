namespace :class_diagram do
  desc 'Generate a class dependency diagram from a given path'
  task :diagram, [:path] => :environment do |_task, args|
    path = args.path
    ClassDiagram.diagram(path: path)
  end
end
