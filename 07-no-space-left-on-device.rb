# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.readlines(chomp: true).map(&:split)

stack = []
sizes = Hash.new 0

INPUT.each do |line|
  case line
  in ['$', 'cd', '/']
    stack = ['root']
  in ['$', 'cd', '..']
    stack.pop
  in ['$', 'cd', name]
    stack.push [stack.last, name].join('/')
  in [size, name] if size.match?(/\d+/)
    stack.each { |folder| sizes[folder] += size.to_i }
  else
    nil
  end
end

puts sizes.values.select { |size| size < 100_000 }.sum
puts sizes.values.select { |size| size > (sizes['root'] + 30_000_000 - 70_000_000) }.min
