########################################################################
#
# Author: Brian Hood
# Name: Crystal private method inheritance example
# Codename:
# Description: 
#   Inherit a private and execute via new method in class Test2
#
#
########################################################################

class Test

  private def test1
    puts "hello"
  end

end

class Test2 < Test
  def mydef
    test1
  end
end

a = Test2.new
a.mydef

