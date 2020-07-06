require 'catalog'

RSpec.describe Catalog do
  describe '.find' do
    it 'finds products by name' do
      expect(described_class.find('apple')).to be_a Product
    end

    it 'returns nil for unknown products' do
      expect(described_class.find('halibut')).to be_nil
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

    it 'only loads data once' do
      described_class.instance_variable_set :@products, nil
      allow(CSV).to receive(:foreach).and_call_original

      5.times { described_class.products }

      expect(CSV).to have_received(:foreach).once
    end
  end
end
