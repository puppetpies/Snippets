########################################################################
#
# Author: Brian Hood
# Name: Crystal Enum Example
# Codename:
# Description: 
#   Enum Examples
#
########################################################################

enum Flags
 Y = 0
 N = 1
end

def enum1(a : Flags)
  puts a.value
end

y = Flags.new(0)
n = Flags.new(1)

enum1(y)
enum1(n)
