# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.read.split("\n\n").map { |line| line.split("\n") }

STACKS = INPUT.first
              .map(&:chars)
              .transpose
              .filter { |a| a.last.match?(/\d+/) }
              .map do |a|
                a.slice(0...-1).reject { |e| e == ' ' }.reverse
              end

ACTIONS = INPUT.last.map { |a| a.scan(/\d+/).map(&:to_i) }

deep_dup = ->(object) { Marshal.load(Marshal.dump(object)) }
stacks1 = deep_dup.call STACKS
stacks2 = deep_dup.call STACKS

ACTIONS.each do |(amount, from, to)|
  amount.times do
    stacks1[to - 1] << stacks1[from - 1].pop
  end

  stacks2[to - 1].concat(stacks2[from - 1].pop(amount))
end

puts stacks1.map(&:last).join
puts stacks2.map(&:last).join
