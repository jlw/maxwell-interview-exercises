# frozen_string_literal: true

require 'catalog'

class Cart
  attr_reader :items

  def initialize
    @items = {}
    @summary_data = nil
  end

  def add_item(name, quantity = 1)
    product = Catalog.find(name)
    return unless product

    clear_summary_data
    @items[product.name] ||= 0
    @items[product.name] += quantity
  end

  def summary_data
    @summary_data ||= {
      items: items_with_cost,
      total_price: @total_price,
      total_savings: @total_savings,
    }
  end

  private

  def items_with_cost
    @total_price = 0
    @total_savings = 0
    items_with_cost = []
    items.each do |product_name, quantity|
      items_with_cost << Catalog.find(product_name).cost_breakdown_for(quantity)
      @total_price += items_with_cost.last.total
      @total_savings += items_with_cost.last.savings
    end
    items_with_cost
  end

  def clear_summary_data
    return if @summary_data.nil?

    @summary_data = nil
    @total_price = nil
    @total_savings = nil
  end
end
