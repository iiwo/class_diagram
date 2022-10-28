# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ClassDiagram::Analyzer::File do
  before do
    allow(ClassDiagram::PathFinder).to receive(:glob).and_return(['/sample/path.rb'])
  end

  describe '#to_h' do
    it 'returns structure hash' do
      tree_hash = [
        {
          key: :module,
          name: 'F',
          namespaces: [],
          children: []
        },
        {
          key: :module,
          name: 'A',
          namespaces: [],
          children: [
            {
              key: :class,
              name: 'C',
              namespaces: ['A'],
              children: []
            },
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
        },
        {
          key: :class,
          name: 'C',
          namespaces: [],
          children: [
            {
              key: :const,
              name: 'B',
              namespaces: ['C'],
              namespaced_names: %w[C::B B]
            }
          ]
        }
      ]

      expect(described_class.new(tree_hash: tree_hash, source_path: '/sample/path.rb').analyze.to_h).to(
        eq(
          [
            {
              name: 'F',
              type: :module,
              path: '/sample/path.rb',
              elements: []
            },
            {
              name: 'A',
              type: :module,
              path: '/sample/path.rb',
              elements: []
            },
            {
              name: 'A::C',
              type: :class,
              path: '/sample/path.rb',
              elements: []
            },
            {
              name: 'A::B',
              type: :class,
              path: '/sample/path.rb',
              elements: [
                {
                  name: 'A::C',
                  type: :const,
                  path: '/sample/path.rb'
                },
                {
                  name: 'F',
                  type: :const,
                  path: '/sample/path.rb'
                },
                {
                  name: 'A::B::D',
                  type: :const,
                  path: '/sample/path.rb'
                },
                {
                  name: 'A::C',
                  type: :const,
                  path: '/sample/path.rb'
                }
              ]
            },
            {
              name: 'A::C::D',
              type: :class,
              path: '/sample/path.rb',
              elements: []
            },
            {
              name: 'C',
              type: :class,
              path: '/sample/path.rb',
              elements: [
                {
                  name: 'B',
                  type: :const,
                  path: '/sample/path.rb'
                }
              ]
            }
          ]
        )
      )
    end
  end
end
