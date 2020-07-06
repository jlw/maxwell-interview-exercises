require 'cart'

RSpec.describe Cart do
  subject(:cart) { described_class.new }

  describe '#add_item' do
    it 'collects a count of selected products' do
      cart.add_item 'apple'

      expect(cart.items['Apple']).to eq 1
    end

    it 'allows for adding multiple quantities at once' do
      cart.add_item 'apple', 2

      expect(cart.items['Apple']).to eq 2
    end

    it 'keeps a single entry for each product' do
      cart.add_item 'apple'
      cart.add_item 'bread'
      cart.add_item 'apple'

      expect(cart.items['Apple']).to eq 2
    end

    it 'ignores unknown products' do
      expect(cart.add_item('lembas')).to be_falsey
    end
  end

  describe '#summary_data' do
    it 'returns calculated items and totals' do
      cart.add_item 'milk', 3
      cart.add_item 'bread', 4
      cart.add_item 'apple'
      cart.add_item 'banana'

      expect(cart.summary_data[:items]).to be_an Array
      expect(cart.summary_data[:items].first.name).to eq 'Milk'
      expect(cart.summary_data[:total_price]).to eq 1902
      expect(cart.summary_data[:total_savings]).to eq 345
    end

    it 're-calculates data if more items are added' do
      cart.add_item 'milk', 3
      cart.summary_data

      cart.add_item 'bread', 4
      cart.add_item 'apple'
      cart.add_item 'banana'

      expect(cart.summary_data[:total_price]).to eq 1902
    end
  end
end
