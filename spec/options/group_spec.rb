# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ClassDiagram::Options::Group do
  let(:group_hash) do
    {
      include: [
        { './spec/dummy/a/c.rb': { follow: false } },
        { './spec/dummy/*.rb': { follow: true } }
      ],
      exclude: [
        { './spec/dummy/f.rb': {} }
      ]
    }
  end

  describe '.include?' do
    context 'with a matching non-excluded element' do
      it 'returns true' do
        expect(
          described_class.new(options_hash: group_hash).include?(path: './spec/dummy/c.rb')
        ).to eq(true)
      end
    end

    context 'with a matching excluded element' do
      it 'returns false' do
        expect(
          described_class.new(options_hash: group_hash).include?(path: './spec/dummy/f.rb')
        ).to eq(false)
      end
    end

    context 'with a not matching element' do
      it 'returns false' do
        expect(
          described_class.new(options_hash: group_hash).include?(path: './spec/dummy/a/b.rb')
        ).to eq(false)
      end
    end
  end

  describe '.follow?' do
    context 'with all includes following' do
      it 'returns true' do
        expect(
          described_class.new(options_hash: group_hash).follow?(path: './spec/dummy/c.rb')
        ).to eq(true)
      end
    end

    context 'with not all includes following' do
      it 'returns false' do
        expect(
          described_class.new(options_hash: group_hash).follow?(path: './spec/dummy/a/c.rb')
        ).to eq(false)
      end
    end
  end
end
