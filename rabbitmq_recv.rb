require 'bunny'

conn = Bunny.new(:hostname => "127.0.0.1", :user => "brian", :pass => "3gtskl9L")
conn.start

ch = conn.create_channel
q = ch.queue("thmdata")

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
n = 1
q.subscribe(:block => true) do |delivery_info, properties, body|
  puts " [#{n}] Received #{body}"
  n = n + 1
  # cancel the consumer to exit
  #delivery_info.consumer.cancel
end

