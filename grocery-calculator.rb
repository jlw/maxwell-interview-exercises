#!/usr/bin/env ruby
# frozen_string_literal: true

lib_dir = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'bundler/setup'
require 'highline'

require 'catalog'
require 'cart'

puts "Our current price list is:"
puts Catalog.table
