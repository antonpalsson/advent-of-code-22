# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.readlines.map { |line| [line[0], line[2..].to_i] }

class Knot
  attr_reader :x, :y, :visited

  def initialize(x: 0, y: 0, next_knot: nil)
    @x = x
    @y = y
    @visited = [@x, @y]
    @next_knot = next_knot
  end

  def move(dx, dy)
    @x += dx
    @y += dy

    @visited.push [@x, @y]

    @next_knot&.follow(self)
  end

  protected

  def follow(knot)
    dx = knot.x - @x
    dy = knot.y - @y

    return if dx.between?(-1, 1) && dy.between?(-1, 1)

    mdx = dx.clamp(-1, 1)
    mdy = dy.clamp(-1, 1)
    move(mdx, mdy)
  end
end

rope = (0...10).each_with_object([]) do |_, acc|
  acc.push Knot.new(next_knot: acc.last)
end.reverse

INPUT.each do |(dir, n)|
  n.times do
    case dir
    when 'U' then rope[0].move(0, 1)
    when 'D' then rope[0].move(0, -1)
    when 'L' then rope[0].move(-1, 0)
    when 'R' then rope[0].move(1, 0)
    end
  end
end

puts rope[1].visited.uniq.length
puts rope[-1].visited.uniq.length
