# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.readlines(chomp: true)

@ty = INPUT.map { |line| line.chars.map(&:to_i) }
@tx = @ty.transpose

def edge?(x, y)
  !x.between?(1, @tx.length - 2) || !y.between?(1, @ty.length - 2)
end

def visible?(x, y)
  return true if edge? x, y

  length = @tx[x][y]
  north = @tx[x][0...y]
  south = @tx[x][y + 1..]
  west = @ty[y][0...x]
  east = @ty[y][x + 1..]

  west.max < length || east.max < length || north.max < length || south.max < length
end

def scenic_score(x, y)
  return 0 if edge? x, y

  length = @tx[x][y]
  north = @tx[x][0...y].reverse
  south = @tx[x][y + 1..]
  west = @ty[y][0...x].reverse
  east = @ty[y][x + 1..]

  n1 = (north.index { |n| n >= length } & + 1) || north.length
  n2 = (south.index { |n| n >= length } & + 1) || south.length
  n3 = (west.index { |n| n >= length } & + 1) || west.length
  n4 = (east.index { |n| n >= length } & + 1) || east.length

  n1 * n2 * n3 * n4
end

visible_count = 0
max_score = 0

coords = (0...@tx.length).to_a.product((0...@ty.length).to_a)

coords.each do |x, y|
  visible_count += 1 if visible?(x, y)
  max_score = [scenic_score(x, y), max_score].max
end

puts visible_count
puts max_score
