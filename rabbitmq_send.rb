require 'bunny'

conn = Bunny.new(:hostname => "127.0.0.1", :user => "brian", :pass => "3gtskl9L")
conn.start

ch = conn.create_channel
q = ch.queue("thmdata")
1.upto(10000) {|n|
  ch.default_exchange.publish("Hello World!", :routing_key => q.name)
  puts " [#{n}] Sent 'Hello World!'"
}

conn.close
