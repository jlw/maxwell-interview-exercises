# frozen_string_literal: true

require 'catalog'

class Checkout
  attr_reader :items

  def initialize
    @items = {}
    @report_data = nil
  end

  def add_item(name, quantity = 1)
    product = Catalog.find(name)
    return unless product

    clear_report_data
    @items[product.name] ||= 0
    @items[product.name] += quantity
  end

  def report_data
    @report_data ||= {
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

  def clear_report_data
    return if @report_data.nil?

    @report_data = nil
    @total_price = nil
    @total_savings = nil
  end
end
