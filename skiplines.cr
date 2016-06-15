
require "option_parser"

class Timers
  
  property? start : Time
  property? finish : Time
  
  def initialize
    @start = Time.now
    @finish = Time.now
    @duration = Time.now
  end
  
  def start
    @start = Time.now
  end
  
  def stop
    @finish = Time.now
  end
  
  def stats
    @duration = @finish - @start
    return "Start: #{@start} Finish: #{@finish} Duration: #{@duration.to_s}"
  end
  
end

class Skiplines
  
  setter skip_lines
  
  def initialize
    @skip_lines = Hash(Int32, Int32).new
    @debug = 2
  end
  
  def skip_processor(filter)
    skip_lines = Hash(Int32, Int32).new
    skipcounter, comb = 0, 0
    puts "Filter: #{filter}"
    filter.to_s.split(",").each {|n|
      if n.split("-").size == 2
        min = n.split("-")[0].to_i
        max = n.split("-")[1].to_i
        min.upto(max) {|u|
          skip_lines.merge!({comb => u.to_i})
          comb = comb + 1
          puts "Comb: #{comb} U: #{u.to_i}" if @debug == 3
        }
      else
        skip_lines.merge!({comb => n.to_i})
        comb = comb + 1
        puts "Comb: #{comb} U: #{n.to_i}" if @debug == 3
      end
    }
    return skip_lines
  end

  def skip(line)
    begin
      line_element = @skip_lines.key(line)
      puts "Line Element: #{line_element}" if @debug == 3
      if line_element != nil
        skiper = true
        return true
      else
        skiper = nil
      end
    rescue KeyError
      puts "Invalid Hash Key" if @debug == 3
    end
    return skiper
  end

end

def option_nameval(var, text)
  puts "#{var}: #{text}"
end

skip = ""

OptionParser.parse! do |parser|
  parser.banner = "Usage: icecrystals [options]"

  parser.on("-s INT", "--skiplines=INT", "Line numbers / sequences") {|s|
    skip = s
    option_nameval("Skiplines", s)
  }

  parser.on("-h", "--help", "Show this help") {|h|
    puts parser
    puts
    exit 0
  }

end

tm = Timers.new
tm.start
s = Skiplines.new
lines = s.skip_processor(skip)
pp lines
s.skip_lines = lines
0.upto(100_000) {|n|
  if s.skip(n) == true
    res = "True"
  else
    res = "False"
  end
  #puts "Skip result: #{res}"
}
puts "Skip lines: #{lines}"
tm.stop
print "\n#{tm.stats}\n"
