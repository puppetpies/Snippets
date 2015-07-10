# Class lookup example / hieracy

class C

  def test(val)
    puts "Superclass"
    @a = 1
  end
  
end

class D < C

  def test(val)
    if val == 5
      super
    else
      puts "self"
      @a = 2
    end
  end
  
end

obj = D.new
obj.test(1)
obj.instance_variable_get("@a")
obj.test(5)
obj.instance_variable_get("@a")

