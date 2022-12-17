# !/usr/bin/ruby ruby
# frozen_string_literal: true

require 'set'

INPUT = ARGF.read

def rock_chunk(*r)
  r[1..].each_with_object([r[0]]) do |to, acc|
    from = acc.last.dup

    loop do
      from[0] -= from[0] <=> to[0]
      from[1] -= from[1] <=> to[1]
      acc.push(from.dup)

      break if from == to
    end
  end
end

rocks = INPUT.split("\n")
             .map { |i| i.scan(/\d+,\d+/) }
             .map { |i| i.map { |j| j.split(',').map(&:to_i) } }
             .each_with_object(Set[]) do |r, acc|
  rock_chunk(*r).each do |rr|
    acc.add(rr.join('_'))
  end
end

rocks_floor = rocks.map { |o| o.split('_').last.to_i }.max + 2
path = [[500, 0]]
sand = Set[]

loop do
  loop do
    x, y = path.last

    if sand.none?("#{x}_#{y + 1}") && rocks.none?("#{x}_#{y + 1}") && y < rocks_floor
      path.push([x, y + 1])
    elsif sand.none?("#{x - 1}_#{y + 1}") && rocks.none?("#{x - 1}_#{y + 1}") && y < rocks_floor
      path.push([x - 1, y + 1])
    elsif sand.none?("#{x + 1}_#{y + 1}") && rocks.none?("#{x + 1}_#{y + 1}") && y < rocks_floor
      path.push([x + 1, y + 1])
    else
      break
    end
  end

  sand.add(path.pop.join('_'))

  break if path.empty?
end

puts(sand.length)
puts(sand.find_index { |i| i.split('_').last.to_i == rocks_floor - 1 })
