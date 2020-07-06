require 'price'

RSpec.describe Price do
  it 'formats prices in cents as dollars' do
    expect(Price.from_cents(130)).to eq '$1.30'
  end
end
