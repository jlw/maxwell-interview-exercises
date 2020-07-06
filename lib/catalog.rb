# frozen_string_literal: true

require 'csv'
require 'product'
require 'titlecase'

class Catalog
  DATA_FILE = File.expand_path('../data/products.csv', __dir__)

  class << self
    def find(name)
      raise ArgumentError, 'Please provide a product name to search for.' unless name.is_a?(String) && !name.empty?

      name.titlecase!
      products.find { |product| product.name == name }
    end

    def products
      load_products if @products.nil?
      @products
    end

    private

    def load_products
      loaded = []
      CSV.foreach(DATA_FILE, headers: true) do |row|
        row = row.to_hash.transform_keys(&:to_sym)
        row[:name].titlecase!
        row[:unit_price] = load_price(row[:unit_price])
        row[:sale_price] = load_price(row[:sale_price])
        loaded << Product.new(row)
      end
      @products = loaded.sort_by(&:name)
    end

    def load_price(price)
      return if price.nil?

      price.gsub!(/^\$/, '')
      (price.to_f * 100).to_i
    end
  end
end
