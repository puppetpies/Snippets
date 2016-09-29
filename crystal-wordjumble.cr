########################################################################
#
# Author: Brian Hood
# Name: Crystal Word jumble example
# Codename: Perplexed Periscope
# Description: 
#   Word jumbles again similar Pumpkin
#
#
########################################################################
require "option_parser"

class Timers
  
  property? start : Time
  property? finish : Time
  
  def initialize
    @start = Time.now
    @finish = Time.now
  end
  
  def start
    @start = Time.now
  end
  
  def stop
    @finish = Time.now
  end
  
  def stats : String
    duration = @finish - @start
    return "Start: #{@start} Finish: #{@finish} Duration: #{duration.to_s}"
  end
  
end

keyword = ""
iterations = 0
quiet = false
appname = "Crystal Word Jumble"

OptionParser.parse! do |parser|

  parser.banner = "Usage: #{appname} [options]"

  parser.on("-w word", "--WORD=apples", "\tWord to jumble") { |w|
    keyword = w
  }
  parser.on("-i iterations", "--ITERATIONS=10", "\tNumber of iterations before performing uniq") { |i|
    iterations = i.to_i
  }
  parser.on("-q quiet", "--QUIET=true", "\tTrue or False Boolean") { |i|
    case i.to_s
    when "true"
      quiet = true
    else
      quiet = false
    end
  }
  parser.on("-h", "--help", "Show this help") {
    puts parser
    exit 0
  }
  parser.unknown_args {|u|
    begin
      keyword = u[0] unless keyword.size > 0
    rescue
      puts "Take a look at the help -h\n"
      puts "Please specify inputfile exiting..."
      exit
    end
  }
end

t = Timers.new
t.start
u = Array(String).new
iterations.times {|n| 
  word = "#{keyword}".split("").shuffle
  u << word.join("")
}

puts "Generating..."
u.uniq.sort.map {|w|
  puts w unless quiet == true
}
t.stop
puts "Number of words generated: #{u.uniq.sort.size}"
puts "Time taken: #{t.stats}"
