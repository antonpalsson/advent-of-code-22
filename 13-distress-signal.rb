# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.read

def compare(left, right)
  case [left, right]
  in [Integer, Integer]
    right <=> left
  in [Array, Array]
    left_dup = left.dup
    right_dup = right.dup

    loop do
      l = left_dup.shift
      r = right_dup.shift

      return 0 if l.nil? && r.nil?
      return 1 if l.nil? && !r.nil?
      return -1 if !l.nil? && r.nil?

      con = compare(l, r)
      return con if con != 0
    end
  in [Array, Integer]
    compare(left, [right])
  in [Integer, Array]
    compare([left], right)
  end
end

puts INPUT.split("\n\n")
          .map { |i| i.split("\n") }
          .map { |i| i.map { |j| eval(j) } }
          .map { |(l, r)| compare(l, r) }
          .each_with_index
          .sum do |o, i|
            o == 1 ? i + 1 : 0
          end

puts INPUT.split("\n")
          .map { |j| eval(j) }
          .push([[2]], [[6]])
          .compact
          .sort { |p1, p2| compare(p2, p1) }
          .each_with_index
          .reduce(1) do |r, (p, i)|
            r * [[[2]], [[6]]].include?(p) ? i + 1 : 1
          end
