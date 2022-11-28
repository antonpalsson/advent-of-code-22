# Advent of code 🕯️🕯️

My [Advent of code 22](https://adventofcode.com/2022) solutions in Ruby

## Goodiness
```
# Run file on save
ls * | grep .rb | entr -c ruby /_ input

# Rubocop
rubocop -A

# Bench
require('benchmark')
require 'benchmark/memory'

n = 10_000

Benchmark.bm do |x|
  x.report('1') { n.times { test1 } }
  x.report('2') { n.times { test2 } }


Benchmark.memory do |x|
  x.report('1') { test1 }
  x.report('2') { test2 }
end
```