# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ClassDiagram::Parser::Tree do
  describe '#to_h' do
    it 'returns nodes hash' do
      data = File.read('./spec/dummy/a/b.rb')
      ast_node = ::Parser::CurrentRuby.parse(data)
      expected_hash = [
        {
          key: :module,
          name: 'A',
          namespaces: [],
          children: [
            {
              key: :class,
              name: 'B',
              namespaces: ['A'],
              children: [
                {
                  key: :const,
                  name: 'A::C',
                  namespaces: %w[A B],
                  namespaced_names: %w[A::B::A::C A::A::C B::A::C A::C]
                },
                {
                  key: :const,
                  name: 'F',
                  namespaces: %w[A B],
                  namespaced_names: %w[A::B::F A::F B::F F]
                },
                {
                  key: :const,
                  name: 'A::B::D',
                  namespaces: %w[A B],
                  namespaced_names: %w[A::B::A::B::D A::A::B::D B::A::B::D A::B::D]
                },
                {
                  key: :const,
                  name: 'A::C',
                  namespaces: %w[A B],
                  namespaced_names: %w[A::B::A::C A::A::C B::A::C A::C]
                }
              ]
            },
            {
              key: :class,
              name: 'C::D',
              namespaces: ['A'],
              children: []
            }
          ]
        }
      ]

      expect(described_class.new(ast_root_node: ast_node).build.to_h).to eq(expected_hash)
    end
  end
end
