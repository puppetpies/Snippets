########################################################################
#
# Author: Brian Hood
# Name: Ruby Word jumble example
# Codename: A Bit yawn
# Description: 
#   Word jumbles again similar Pumpkin
#
#
########################################################################
require 'getoptlong' 

module Jublistmassive

  class Timers

    attr_reader :t1, :t2

    def duration
      @t2 - @t1
    end
   
    def stats
      return "Start: #{Time.at(@t1)} Finish: #{Time.at(@t2)} Duration: #{duration}"
    end
    
    def start
      @t1 = Time.now.to_f
    end
    
    def stop
      @t2 = Time.now.to_f
    end

  end

  ARGV[0] = "--help" if ARGV[0] == nil
  iterations = 0
  keyword = String.new
  quiet = false
  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--word', '-w', GetoptLong::REQUIRED_ARGUMENT],
    [ '--iterations', '-i', GetoptLong::OPTIONAL_ARGUMENT],
    [ '--quiet', '-q', GetoptLong::OPTIONAL_ARGUMENT],
  )

  opts.each do |opt, arg|
    case opt
      when '--help'
        helper = "Ruby Word Jumble"
        helper << "\n-w word STRING"
        helper << "\n-i iterations INTEGER"
        helper << "\n-q quiet BOOL"
        puts helper
        exit
      when '--quiet'
        case arg.to_s
        when "true", ""
          quiet = true
        else
          quiet = false
        end
      when '--word'
        keyword = arg.to_s
      when '--iterations'
        iterations = arg.to_i
    end
  end

  t = Timers.new
  t.start
  u = Array.new
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

end
