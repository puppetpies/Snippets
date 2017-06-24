# #######################################################################
#
# Author: Brian Hood
# Name: Examples
# Email: <brianh6854@googlemail.com>                                   #
# 
# Description: Reading / Cloning a file
# #######################################################################


inputfile = "/tmp/recording.avi"
outputfile = "/tmp/recording2.avi"

puts "Reading in file"
fstr = File.read(inputfile)

begin
  puts "Create file"
  File.open("#{outputfile}", "w") {|n|
    n.print(fstr)
  }
  puts "Done!"
rescue 
  raise "Can't create file please check file / directory permissions"
end 
