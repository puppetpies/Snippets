class File < IO::FileDescriptor

#  def self.count_lines(filename, encoding = nil, invalid = nil)
#    lines = 0
#    each_line(filename, encoding: encoding, invalid: invalid).cycle(n) do |line|
#      lines += 1
#    end
#    lines
#     each_line(filename) do |line|
#       line.each.cycle(1).size
#     end

#  def self.count_lines(filename, encoding = nil, invalid = nil)
#    File.open(filename).each_line.size
#  end

  def self.count_lines(filename, encoding = nil, invalid = nil)
    if File.exists?(filename)
      file = File.new(filename) # .each_line.size
      begin
        yield file
      ensure
        file.close
      end
    else
      raise Errno.new("Error file does not exist")
    end
  end

end

File.count_lines("shard.yml") do |n|
 puts n.each_line.size
end

File.count_lines("sdf.yml") do |n|
 puts n.each_line.size
end


