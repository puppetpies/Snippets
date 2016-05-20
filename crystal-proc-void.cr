proc = Proc(Pointer(UInt8), Void).new do |foo|
  puts String.new(foo)
end
slice = "foo".to_slice
proc.call(slice.pointer(slice.size))
puts pointerof(proc).class
