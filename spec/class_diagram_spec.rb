# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ClassDiagram do
  it 'has a version number' do
    expect(ClassDiagram::VERSION).not_to be nil
  end

  describe 'runs task' do
    it 'prints graph' do
      expect do
        ClassDiagramCLI.new.invoke(:diagram, [], { config: './spec/dummy/.class_diagram.yml' })
      end.to output("graph LR\n").to_stdout
    end
  end
end
