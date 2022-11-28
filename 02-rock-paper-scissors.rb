# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.readlines(chomp: true)

points1 = 0
points2 = 0

INPUT.each do |round|
  points1 += 1 if round.end_with? 'X' # Rock
  points1 += 2 if round.end_with? 'Y' # Paper
  points1 += 3 if round.end_with? 'Z' # Scissor
  points1 += 3 if ['A X', 'B Y', 'C Z'].any? round # Draw
  points1 += 6 if ['A Y', 'B Z', 'C X'].any? round # Win

  points2 += 1 if ['B X', 'A Y', 'C Z'].any? round # Rock
  points2 += 2 if ['C X', 'B Y', 'A Z'].any? round # Paper
  points2 += 3 if ['A X', 'C Y', 'B Z'].any? round # Scissor
  points2 += 3 if round.end_with? 'Y' # Draw
  points2 += 6 if round.end_with? 'Z' # Win
end

puts points1
puts points2
