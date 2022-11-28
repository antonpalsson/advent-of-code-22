# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.readlines(chomp: true).map do |line|
  n = line.scan(/-?\d+/).first
  n.nil? ? nil : n.to_i
end

register = INPUT.each_with_object([1]) do |value, acc|
  last = acc.last
  value.nil? ? acc.push(last) : acc.push(last, last + value)
end

sum = [20, 60, 100, 140, 180, 220].sum { |c| c * register[c - 1] }
puts sum

WIDTH = 40
HEIGHT = 6
screen_buffer = (0...(WIDTH * HEIGHT)).zip(register).each_with_object([]) do |(cycle, x), acc|
  vertical_pos = cycle % WIDTH
  lit = (x - vertical_pos).between?(-1, 1)
  lit ? acc.push('#') : acc.push('.')
end

print = screen_buffer.each_slice(WIDTH).map(&:join)
puts print
