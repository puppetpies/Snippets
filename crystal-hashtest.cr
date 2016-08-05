########################################################################
#
# Author: Brian Hood
# Name: Crystal hash tables example
# Codename:
# Description: 
#   Hash tables within hash tables
#
#
########################################################################

a = {0 => {"test" => "me"}}
p a[0]
p a[0]["test"]
a.merge!({1 => {"test1" => "test1"}})
p a[1]
p a[1]["test1"]
a.merge!({2 => {"orange" => "apple"}})
p a[2]["orange"]
a.merge!({3 => {"orange" => "apple", "green" => "pepper"}})
p a[3]["orange"]
p a[3]["green"]

p a
p a.class

res = a
0.upto(a.size - 1) {|n|
  p res[n]
}

# You write this as below
#a = Hash(Int32, Hash(String, String)).new; 
# Or this using of !
a = {} of Int32 => Hash(String, String)
a.merge!({0 => {"test" => "test"}}); 
a.merge!({1 => {"test" => "test"}}); 
p a.inspect; 
a.each do |n,x| 
  puts "Record: #{n}"; 
  x.each do |y,z| 
    puts "K: #{y} V: #{z}" 
  end 
end
