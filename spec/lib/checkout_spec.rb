require 'checkout'

RSpec.describe Checkout do
  subject(:checkout) { described_class.new }

  describe '#add_item' do
    it 'collects a count of selected products' do
      checkout.add_item 'apple'

      expect(checkout.items['Apple']).to eq 1
    end

    it 'allows for adding multiple quantities at once' do
      checkout.add_item 'apple', 2

      expect(checkout.items['Apple']).to eq 2
    end

    it 'keeps a single entry for each product' do
      checkout.add_item 'apple'
      checkout.add_item 'bread'
      checkout.add_item 'apple'

      expect(checkout.items['Apple']).to eq 2
    end

    it 'ignores unknown products' do
      expect(checkout.add_item('lembas')).to be_falsey
    end
  end

  describe '#report_data' do
    it 'returns calculated items and totals' do
      checkout.add_item 'milk', 3
      checkout.add_item 'bread', 4
      checkout.add_item 'apple'
      checkout.add_item 'banana'

      expect(checkout.report_data[:items]).to be_an Array
      expect(checkout.report_data[:items].first.name).to eq 'Milk'
      expect(checkout.report_data[:total_price]).to eq 1902
      expect(checkout.report_data[:total_savings]).to eq 345
    end

    it 're-calculates data if more items are added' do
      checkout.add_item 'milk', 3
      checkout.report_data

      checkout.add_item 'bread', 4
      checkout.add_item 'apple'
      checkout.add_item 'banana'

      expect(checkout.report_data[:total_price]).to eq 1902
    end
  end
end
