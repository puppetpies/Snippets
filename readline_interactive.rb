########################################################################
#
# MyMenu Readline interactive menu builder
#  
# Author: Brian Hood 
# Description: Build interactive menu's with Readline quickly
# 
########################################################################
 
require 'readline'

class MyMenu

  attr_writer :mymenuname, :mymenugreeting, :prompt, :promptcolor, :menutitlecolour, :mymenushow
  attr_reader :menuitems
  
  def initialize
    @mymenuname = "MyMenu"
    @prompt = "MyPrompt"
    @promptcolor = "\e[1;32m\ ".strip
    @menuitems = Array.new
    @menuitemnumbercolor = "\e[1;36m"
    @mymenugreeting = "Welcome to MyMenu"
    @mymenutoggle = true
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
  
  def additemtolist(number, name, func)
    @menuitems << [number, "#{name}", "#{func}"]
  end
  
  def showmenu
    unless @mymenutoggle == false
      puts @menutitle
      @menuitems.each {|n|
        puts "#{@menuitemnumbercolor}#{n[0]})\e[0m\ #{n[1]}"        
      }
      puts "\n"
    end
  end
  
  def togglemenu
    if @mymenutoggle == true
      @mymenutoggle = false
      puts "Toggle Menu: #{@mymenutoggle}"
    else
      @mymenutoggle = true
      puts "Toggle Menu: #{@mymenutoggle}"
    end
  end
  
  def menu!
    menubuilder
    createmenu("0")
    showmenu
    while buf = Readline.readline("#{@promptcolor}#{@prompt}>\e[0m\ ", true)
      trap("INT") {
        puts "\nGoodbye see yall later!!!"
        exit
      }
      begin
        showmenu
        createmenu(buf)
      rescue NoMethodError
      end
    end
  end
  
  def evalreadline(&block)
    while buf2 = Readline.readline("#{@promptcolor}#{@prompt}>\e[0m\ ", true)
      puts "Here5"
      block.call
      puts "Here6"
    end
  end
  
  def evalreadline?(readlineprompt, &codeeval)
    if readlineprompt == false
      puts "Here3"
      codeeval.call
    else
      puts "Here4"
      evalreadline do
        codeeval
      end
    end
  end
  
  def definemenuitem(func, readlineprompt=false, args=nil, &codeeval)
    func_name = func.to_sym
    if args == nil
      Kernel.send :define_method, func_name do
        evalreadline?(readlineprompt) do
          puts "Here"
          codeeval.call
        end
      end
    else
      Kernel.send :define_method, func_name do |args|
        evalreadline?(readlineprompt) do
          puts "Here2"
          codeeval.call
        end
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
    puts "Dynamic Merge: #{merge}".gsub(";", "\n")
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
x.definemenuitem("listfilters") do
  puts "My List filters block"
end
x.definemenuitem("setfilters") do
  #puts "My Set filters block"
  y = MyMenu.new
  y.prompt = "Trafiz {Filters}>"
  y.definemenuitem("setfilter", true) do
    puts "Hello"
    break
  end
  y.setfilter
end
# Define your list items
x.additemtolist(1, "List Filters", "listfilters;")
x.additemtolist(2, "Set Filters", "setfilters;")
x.additemtolist(3, "Display Menu", "showmenu;")
x.additemtolist(4, "Toggle Menu", "togglemenu;")
x.additemtolist(5, "Exit Trafviz", "exit;")
x.menu!
