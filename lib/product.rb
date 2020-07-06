# frozen_string_literal: true

ProductCost = Struct.new :name, :quantity, :total, :savings

class Product
  attr_reader :name, :unit_price, :sale_quantity, :sale_price

  def initialize(name:, unit_price:, sale_quantity: nil, sale_price: nil)
    @name = name
    @unit_price = unit_price
    @sale_quantity = sale_quantity
    @sale_price = sale_price
  end

  def cost_breakdown_for(quantity)
    product_cost = ProductCost.new name, quantity, unit_price * quantity, 0
    return product_cost unless sale?

    calculate_sale_cost(product_cost)
  end

  def sale?
    !sale_quantity.nil? && !sale_price.nil?
  end

  private

  def calculate_sale_cost(product_cost)
    base_cost = product_cost.total
    bundles, full_cost_units = product_cost.quantity.divmod(sale_quantity)

    product_cost.total = (bundles * sale_price) + (full_cost_units * unit_price)
    product_cost.savings = base_cost - product_cost.total
    product_cost
  end
end
