require 'readline'
require 'pp'

class MyMenu

  attr_reader :line
  
  def initialize
    #@line = String.new
    @prompt = "MyBlockTest"
    @debug = 2
  end

  class << self
  
    def evalreadline(&block)
      while buf2 = Readline.readline("#{@promptcolor}#{@prompt}>\e[0m\ ", true)
        puts "Eval Readline Pre execution" #if @debug >= 2
        block.instance_eval do |t|
          puts "Set @line"
          methods
          instance_variable_set("@line", buf2)
          #return @line
        end
        puts "PP instance variable"
        pp block.instance_variable_get("@line")
        block.call
        puts "Post execution of block in Readline prompt" #if @debug >= 2
        break
      end
      return block.instance_variable_get("@line")
    end

  end

end

x = MyMenu::evalreadline do
  puts "Just a test"
end

puts "A: #{x)"
