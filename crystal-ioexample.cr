class MyBox4
  def initialize(@value : IO); end
  def add(msg)
    @value << msg
  end
end

msg = "some data"
io = MemoryIO.new
mio = MyBox4.new(io)
mio.add(msg)
