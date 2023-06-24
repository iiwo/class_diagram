# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ClassDiagram::Constantizers::Project do
  describe '#find' do
    it 'finds member with a matching name' do
      project_data = [
        { name: 'A::B', path: '/sample/path.rb' },
        { name: 'C::D', path: '/sample/path.rb' },
        { name: 'E::F', path: '/sample/path.rb' }
      ]

      dummy_project = double(members: project_data)

      expect(
        described_class.new(
          project: dummy_project
        ).find(namespaced_names: %w[Z::Q C::D P::R])
      ).to(
        eq(
          name: 'C::D',
          path: '/sample/path.rb'
        )
      )
    end
  end
end
