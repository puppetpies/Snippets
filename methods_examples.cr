
class MyTest
  
  def self.singleton
    puts "Singleton method"
  end

  private def priv_test
    puts "Private Test: Private method I'm only available in current scope"
  end

  def pub_test_1
    puts "Public method lookup of : priv_test: Private method"
    priv_test
  end
  
  def pub_test_2
    puts "Public method lookup of : prot_test: Protected method"
    prot_test
  end

  protected def prot_test
    puts "Protected method lookup of : pub_test_1: Public method"
    pub_test_1
    puts "Protected method lookup of : priv_test: Private Method"
    priv_test
  end

end

my = MyTest.new
my.pub_test_1
my.pub_test_2

MyTest.singleton

