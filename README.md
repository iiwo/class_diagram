# ClassDiagram

:construction: :construction: WIP :construction: :construction:

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'class_diagram', git: 'https://github.com/iiwo/class_diagram', group: 'development'
```

And then execute:

    $ bundle install

## Usage

with cli:

```shell
> bundle exec class_diagram help diagram

Usage:
  class_diagram diagram

Options:
  -p, [--path=PATH]                # path to Ruby class file
  -o, [--output=OUTPUT]            # target output for the diagram exporter
                                   # Default: console
                                   # Possible values: console, file
  -f, [--format=FORMAT]            # format of the diagram output
                                   # Default: text
                                   # Possible values: text, html
  -e, [--export-path=EXPORT_PATH]  # path for the file output (only used with file output)

Generate class diagram
```

example:
```shell
 bundle exec class_diagram diagram -p app/controllers/some_controller.rb -f html -o file -e ./diagrams/some_controller.html
```


with Rails console:

```ruby
ClassDiagram.diagram(path: 'app/path/to/your/class.rb')
```