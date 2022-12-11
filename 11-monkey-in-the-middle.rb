# !/usr/bin/ruby ruby
# frozen_string_literal: true

Monkey = Struct.new(:i, :op, :div, :tm, :fm, :p)

monkeys = ARGF.read.split("\n\n").map do |sektion|
  lines = sektion.split("\n")

  i = lines[1].scan(/\d+/).map(&:to_i)
  op_str = lines[2].scan(/old .+/).first
  op = eval "->(old) {#{op_str}}"
  div = lines[3].scan(/\d+/).first.to_i
  tm = lines[4].scan(/\d+/).first.to_i
  fm = lines[5].scan(/\d+/).first.to_i

  Monkey.new(i, op, div, tm, fm, 0)
end

divs = monkeys.map(&:div).reduce(:*) # magic

10_000.times do |i|
  puts monkeys.map(&:p).max(2).reduce(&:*) if i == 20

  monkeys.each do |monkey|
    until monkey.i.empty?
      item = monkey.i.shift
      item = monkey.op.call(item) % divs # magic
      monkey.p += 1

      if (item % monkey.div).zero?
        monkeys[monkey.tm].i.push item
      else
        monkeys[monkey.fm].i.push item
      end
    end
  end
end

puts monkeys.map(&:p).max(2).reduce(:*)
