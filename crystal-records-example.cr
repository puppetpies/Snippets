record Person, first_name : String, last_name : String do
  property? first_name : String
  property? last_name : String
  
  def initialize
    @first_name = "test"
    @last_name = "test"
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def first
    puts "#{@first_name}"
  end
  
  def last
    puts "#{@last_name}"
  end
  
end

# crystal-icr#23
record Person, first_name : String, last_name : String do
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
end

a = Person.new("Mike", "Nog")
p a

#t = {Person.new("John", "Smith"), Person.new("John", "Doe")}
#p t
#p t[0].full_name
#p t[1].full_name

a = Person.new("Mike", "Nog")
p "First: #{a.first} Last: #{a.last}"
p "Full Name: #{a.full_name}"

class Test
  def initialize
  
  end
  
  def t1
    a = 1
  end
  
  def t2
    a = 2
  end
  
end
