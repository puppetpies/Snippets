########################################################################
#
# filtermanager.rb
#  
# Author: Brian Hood 
# Description:
# 
########################################################################
 
require 'readline'
require 'pcaplet'
require 'getoptlong'

class MyMenu

  attr_writer :mymenuname, :mymenugreeting, :prompt, :promptcolor, :menutitlecolour
  
  def initialize
    @filters = Array.new
    @filter_inuse = String.new
    @mymenuname = "MyMenu"
    @prompt = "MyPrompt"
    @promptcolor = "\e[1;32m\ ".strip
    @menuitems = Array.new
    @menuitemnumbercolor = "\e[1;36m"
    @mymenugreeting = "Welcome to MyMenu"
  end

  def settitle(title)
    @mymenugreeting = title
    @menutitlecolor = "\e[1;38m"    
    @menutitle = %Q{\n
/=========================\e[0m\ 
\e[1;38m|   #{@mymenugreeting}    |\e[0m\ 
\e[1;38m\=========================/\e[0m\ \n
}
  end
  
  def additem(number, name)
    @menuitems << [number, "#{name}"]
  end
  
  def menu!
    while buf = Readline.readline("#{@promptcolor}#{@prompt}>\e[0m\ ", true)
      begin
        puts @menutitle
        @menuitems.each {|n|
          puts "#{@menuitemnumbercolor}#{n[0]})\e[0m\ #{n[1]}"        
        }
        puts "\n"
        puts "m: This menu"
        puts "q: Exit #{@mymenuname}\n"
        puts "\n"
        case buf
        when "1"
        when "2"

        when "m"
        when "q"
          exit
        end
      rescue NoMethodError
      end
    end
  end
  
end

x = MyMenu.new
x.settitle("Welcome to Trafviz")
x.mymenuname = "Trafviz"
x.prompt = "Trafviz"
x.additem(1, "List Filters")
x.additem(2, "Set Filters")
x.menu!
