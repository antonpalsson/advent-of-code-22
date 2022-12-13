# !/usr/bin/ruby ruby
# frozen_string_literal: true

V = Struct.new(:x, :y, :h, :dist) do
  def elevation_diff(other)
    c1 = h
    c2 = other.h
    c1 = c1.tr('SE', 'az')
    c2 = c2.tr('SE', 'az')
    c2.ord - c1.ord
  end

  private

  def <=>(other)
    return 1 if dist.nil?
    return -1 if other.dist.nil?

    dist <=> other.dist
  end

  def ==(other)
    x == other.x && y == other.y
  end
end

def dijkstra(map, start_h, reverse: false)
  map.flatten.each { |v| v.dist = nil }
  start = map.flatten.find { |v| v.h == start_h }
  start.dist = 0

  queue = [start]
  done = []

  until queue.empty?
    queue.sort!
    cur_v = queue.shift
    done.push(cur_v)

    next_vs = [
      [cur_v.x + 1, cur_v.y],
      [cur_v.x - 1, cur_v.y],
      [cur_v.x, cur_v.y + 1],
      [cur_v.x, cur_v.y - 1]
    ].map do |(x, y)|
      map[x][y] if x.between?(0, map.length - 1) && y.between?(0, map.first.length - 1)
    end.compact

    next_vs = next_vs.select do |adj_v|
      reverse ? cur_v.elevation_diff(adj_v) >= -1 : adj_v.elevation_diff(cur_v) >= -1
    end

    next_vs.each do |next_v|
      next if queue.any?(next_v) || done.any?(next_v)

      next_v.dist = cur_v.dist + 1
      queue.push(next_v)
    end
  end
end

map = ARGF.readlines(chomp: true)
          .map(&:chars)
          .transpose
          .each_with_index.map do |r, i|
  r.each_with_index.map do |h, j|
    V.new(i, j, h)
  end
end

dijkstra(map, 'S')
puts map.flatten.find { |v| v.h == 'E' }.dist

dijkstra(map, 'E', reverse: true)
puts map.flatten.sort.find { |v| v.h == 'a' }.dist
