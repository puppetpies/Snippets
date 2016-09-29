record Person, first_name : String, last_name : String do
  
  def initialize

  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
end

a = Person.new("Mike", "Nog")
