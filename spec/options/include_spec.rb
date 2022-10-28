# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ClassDiagram::Options::Include do
  describe '#match?' do
    context 'without options' do
      it 'uses defaults' do
        expect(described_class.new.match?(path: './spec/dummy/c.rb')).to eq(true)
      end
    end

    context 'with matching value' do
      it 'returns true' do
        expect(
          described_class.new(options_hash: { './spec/dummy/c.rb': {} }).match?(path: './spec/dummy/c.rb')
        ).to eq(true)
      end

      context 'with glob' do
        it 'returns true' do
          expect(
            described_class.new(options_hash: { './**/c.rb': {} }).match?(path: './spec/dummy/c.rb')
          ).to eq(true)
        end
      end
    end

    context 'with not matching value' do
      it 'returns false' do
        expect(
          described_class.new(options_hash: { './spec/dummy/a.rb': {} }).match?(path: './spec/dummy/c.rb')
        ).to eq(false)
      end

      context 'with glob' do
        it 'returns false' do
          expect(
            described_class.new(options_hash: { './**/a.rb': {} }).match?(path: './spec/dummy/c.rb')
          ).to eq(false)
        end
      end
    end
  end
end
