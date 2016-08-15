########################################################################
#
# Author: Brian Hood
# Name: Crystal Generics examples
# Codename:
# Description: 
#   StaticArray / Syntax & Semantics notes and a bug
#
#
########################################################################

class MyBox(T, T2, T3)

  property? value : Float64 = 0.1
  property? value2 : Array(Int32) | Array(String)
  
  def initialize(@value : T, @value2 : T2, @value3 : T3)
  end

  def value
    @value
  end

  def value2
    puts @value2.class
    @value2.each do |n|
      puts n
    end
  end

  def value3
    @value3
  end
  
end

# crystal eval 'class Args(*T); @args : T; def initialize(*@args : *T); end; end'

# Breaks compiler due to invalid type for T #3157
#
# crystal eval 'class MyBox3(T); property? value : Array(String); def initialize(@value : T); end ;end'

class MyBox3(T)
  property? value : Array(String)
  def initialize(@value : T); end
end

a = MyBox3(2).new("test")

#class MyBox4(T)
#  property? value2 : Array(Int32) | String
#  def initialize(@value : T); end
#end

#a = MyBox3(3).new(["test"]);

#i = Array(Int32).new
#i << 3
#i << 4
#string_box = MyBox(Float64, Array(Int32), String).new(0.4, i, "am floating")
#p string_box.value
#string_box.value2
#p string_box.value3

