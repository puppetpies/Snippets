require 'amqp'
require 'pp'

      EventMachine.run do
        connection = AMQP.connect(:host => "127.0.0.1", :user => "brian", :pass => "3gtskl9L")
        sleep(2)
        pp connection
        
        puts "Connected to AMQP broker. Running #{AMQP::VERSION}"
        channel  = AMQP::Channel.new(connection)
        channel
        puts "Queue: wifi_ippacket"
        queue    = channel.queue("wifi_ippacket")
        queue
        exchange = channel.direct("")
        exchange
        #queue.subscribe do |payload|
        #  puts "Received a message: #{payload}. Disconnecting..."
        #  connection.close { EventMachine.stop }
        #end
        n = 1
        queue.bind("wifi_ippacket").subscribe do |metadata, payload|
          # message handling implementation...
          puts "ID #{n} : Data: #{payload}"
        end
      end
