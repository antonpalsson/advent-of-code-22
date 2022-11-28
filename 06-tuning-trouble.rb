# !/usr/bin/ruby ruby
# frozen_string_literal: true

INPUT = ARGF.read.chars

cursor1 = nil
cursor2 = nil

def start_marker?(seq)
  seq.uniq.length == seq.length
end

INPUT.length.times do |cursor|
  cursor1 ||= cursor if start_marker? INPUT[cursor...cursor + 4]
  cursor2 ||= cursor if start_marker? INPUT[cursor...cursor + 14]

  break unless cursor1.nil? || cursor2.nil?
end

puts cursor1
puts cursor2
