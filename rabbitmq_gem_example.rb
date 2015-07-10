require 'rabbitmq'

a = RabbitMQ::Connection.new(:host => "127.0.0.1", :user => "brian", :password => "3gtskl9L")
a.start
b = RabbitMQ::Channel.new(a, 2)
b.queue_declare("test") # Create Queue
b.queue_bind("test", "ippacket") 
# Send message
b.basic_publish("test", "ippacket", "") # body, exchange, routing_key

