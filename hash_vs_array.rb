require 'walltime'
require 'pp'
#require 'mutex'

def random_alphabet
  a = "abcdefghijklmnopqrstuvwxyz"
  c = String.new
  26.times {
    b = rand(26)
    c << a[b..b]
  }
  return c
end

def hash_friend(num)
  watch = Stopwatch.new
  watch.start
  p = Hash.new
  num.times {|n|
    h ||= random_alphabet
    #print "#{h} "
    p.update({rand(50000) => "#{h}"})
  }
  watch.stop
  watch.print_stats
end

def array_friend(num)
  watch = Stopwatch.new
  watch.start
  p = Array.new
  num.times {|n|
    h ||= random_alphabet
    p.insert(rand(50000), "#{h}")
  }
  watch.stop
  watch.print_stats
end

hash_friend(50000)
array_friend(50000)
