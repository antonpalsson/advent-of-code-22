# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.readlines(chomp: true)

def item_prio(char)
  char == char.upcase ? char.ord - 38 : char.ord - 96
end

sum1 = INPUT.sum do |rucksack|
  left = rucksack[0...rucksack.length / 2]
  right = rucksack[rucksack.length / 2...rucksack.length]

  item = (left.chars & right.chars).first
  item_prio item
end

sum2 = INPUT.each_slice(3).sum do |(r1, r2, r3)|
  item = (r1.chars & r2.chars & r3.chars).first
  item_prio item
end

puts sum1
puts sum2
