# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.readlines.map { |line| line.scan(/\d+/).map(&:to_i) }

sum1 = 0
sum2 = 0

INPUT.each do |(l1, r1, l2, r2)|
  sum1 += 1 if (l1.between?(l2, r2) && r1.between?(l2, r2)) || (l2.between?(l1, r1) && r2.between?(l1, r1))
  sum2 += 1 if l1.between?(l2, r2) || r1.between?(l2, r2) || l2.between?(l1, r1) || r2.between?(l1, r1)
end

puts sum1
puts sum2
