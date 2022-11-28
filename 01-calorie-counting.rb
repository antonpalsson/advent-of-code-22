# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.readlines.map(&:to_i)

calories_list = INPUT.slice_before(0).map(&:sum)

puts calories_list.max
puts calories_list.max(3).sum
