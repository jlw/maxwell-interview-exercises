require 'product'

RSpec.describe Product do
  it 'calculates non-sale prices with product info' do
    product = described_class.new name: 'Artichoke', unit_price: 7
    cost = product.cost_breakdown_for(3)

    expect(cost.name).to eq 'Artichoke'
    expect(cost.quantity).to eq 3
    expect(cost.total).to eq 21
    expect(cost.savings).to eq 0
  end

  it 'calculates sale prices with product info' do
    product = described_class.new name: 'Beet', unit_price: 5, sale_quantity: 3, sale_price: 12
    cost = product.cost_breakdown_for(4)

    expect(cost.name).to eq 'Beet'
    expect(cost.quantity).to eq 4
    expect(cost.total).to eq 17
    expect(cost.savings).to eq 3
  end
end
