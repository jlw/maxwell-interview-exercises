require 'catalog'

RSpec.describe Catalog do
  describe '.find' do
    it 'finds products by name' do
      expect(described_class.find('apple')).to be_a Product
    end

    it 'returns nil for unknown products' do
      expect(described_class.find('halibut')).to be_nil
    end

    it 'requires a non-empty string' do
      [
        nil,
        '',
        5,
        :yes_even_a_symbol,
      ].each do |input|
        expect { described_class.find(input) }.to raise_exception(ArgumentError)
      end
    end
  end

  describe '.products' do
    it 'has a list of known products' do
      expect(described_class.products).to be_an Array

      product = described_class.products.first
      expect(product).to be_a Product
      expect(product.name).to eq 'Apple'
      expect(product.unit_price).to eq 89
    end
  end
end
