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
  attr_reader :menuitems
  
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
  
  def additem(number, name, func)
    @menuitems << [number, "#{name}", "#{func}"]
  end
  
  def menu!
    menubuilder
    createmenu("0")
    while buf = Readline.readline("#{@promptcolor}#{@prompt}>\e[0m\ ", true)
      begin
        puts @menutitle
        @menuitems.each {|n|
          puts "#{@menuitemnumbercolor}#{n[0]})\e[0m\ #{n[1]}"        
        }
        puts "\n"
        createmenu(buf)
      rescue NoMethodError
      end
    end
  end
  
  def funcdefine(func, args=nil, &codeeval)
    func_name = func.to_sym
    if args == nil
      Kernel.send :define_method, func_name do
        codeeval.call
      end
    else
      Kernel.send :define_method, func_name do |args|
        codeeval.call
      end    
    end
  end
  
  def menubuilder
    head = "buf ||= String.new; case buf; "
    y = 1
    mc = String.new
    mc << "when \"0\"; "
    @menuitems.each {|n|
      mc << "when \"#{n[0]}\"; "
      func_name = "#{n[2]}".gsub(";", "")
      mc << " if !defined?(#{func_name}); puts \"\e[1;31m\Function not defined #{func_name}\e[0m\ \"; exit; end; "
      mc << "#{n[2]}"
      y += 1
    }
    tail = "end"
    merge = "#{head}#{mc}#{tail}"
    #puts "Merge: #{merge}"
    Kernel.send :define_method, :createmenu do |buf|
      eval(merge)
    end
  end
  
end

x = MyMenu.new
x.settitle("Welcome to Trafviz")
x.mymenuname = "Trafviz"
x.prompt = "Trafviz"
# Add my methods
x.funcdefine("listfilters") do
  puts "My List filters block"
end
x.funcdefine("setfilters") do
  puts "My Set filters block"
end
x.additem(1, "List Filters", "listfilters;")
x.additem(2, "Set Filters", "setfilters;")
x.additem(3, "Exit Trafviz", "exit;")
x.menu!
