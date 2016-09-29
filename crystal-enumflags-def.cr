
enum Flags
 Y = 1
 N = 2
end
p Flags::N.value

def test(a : Flags)
  puts a.value
end

test(Flags::Y)
