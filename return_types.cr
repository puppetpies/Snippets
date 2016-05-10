

class Test

  def initialize
    @str = Array(String).new
    @str2 = Array(String).new
  end

end

class Test2 < Test

  def initialize
    super
  end

  def arrstring2
    @str2 = Array(String).new
    @str2 << "hi"
    @str2 << "you"
    t = arrstring
    return t
  end

  def arrstring
    @str = Array(String).new
    @str << "hello"
    @str << "you"
    return @str
  end

end

t = Test2.new
a = t.arrstring2
a.each {|n|
  puts n
}



