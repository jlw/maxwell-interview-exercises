# frozen_string_literal: true

require 'csv'
require 'product'
require 'titlecase'

class Catalog
  DATA_FILE = File.expand_path('../data/products.csv', __dir__)

  class << self
    def find(name)
      raise ArgumentError, 'Please provide a product name to search for.' unless name.is_a?(String) && !name.empty?

      name = name.titlecase
      products.find { |product| product.name == name }
    end

    def products
      load_products if @products.nil?
      @products
    end

    private

    def cleaned_product(row)
      row = row.to_hash.transform_keys(&:to_sym)
      row[:name].titlecase!
      row[:unit_price] = load_price(row[:unit_price])
      row[:sale_quantity] = row[:sale_quantity].to_i unless row[:sale_quantity].nil?
      row[:sale_price] = load_price(row[:sale_price])
      Product.new(row)
    end

    def load_products
      loaded = []
      CSV.foreach(DATA_FILE, headers: true) do |row|
        loaded << cleaned_product(row)
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
