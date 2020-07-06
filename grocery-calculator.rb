#!/usr/bin/env ruby
# frozen_string_literal: true

lib_dir = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'bundler/setup'
require 'highline'

require 'catalog'
require 'cart'

puts 'Our current price list (from data/products.csv) is:'
puts Catalog.table
puts "\n1. Please enter each item in your cart, one at a time."
puts '   (Note: you do not need to capitalize item names.)'
puts '2. If you have more than one, you can add the quantity after a space (e.g. "apple 2").'
puts '3. When you are done, simply hit return again.'
puts ''

cart = Cart.new

cli = HighLine.new
while (raw_input = cli.ask("What is the #{cart.empty? ? 'first' : 'next'} item in your cart?"))
  break if raw_input.nil? || raw_input.empty?

  item_name, quantity = raw_input.split(' ')
  quantity = quantity.to_i
  quantity = 1 if quantity.zero?
  result = cart.add_item(item_name, quantity)
  next if result

  cli.say 'Sorry, we could not find that item; please try again.'
end

puts 'Your grocery items are:'
puts cart.summary
puts 'Thank you for shopping with us!'
