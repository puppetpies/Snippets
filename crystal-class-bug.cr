class A
  def self.initialize
    @d = 1 
  end
  def test
    puts "hello #{@d}"
  end; end
a = A.new
a.test
#hello 0

class A
 def initialize
  @d = 1 
 end
 def test
   puts "hello #{@d}"
 end
end 
a = A.new
a.test

#hello 1
 
