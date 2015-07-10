require 'digest'
hash = Digest::SHA512.new
hash.update("mytest")
puts hash.hexdigest
puts hash.hexdigest.size
