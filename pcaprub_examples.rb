
== Examining Packet Internals
PCAPRUB Examples

Sniffing and yielding Packet Objects using "each_packet"

require 'pcaplet'

in_filename = "Example.pcap"
inp = Pcap::Capture.open_offline(in_filename)
inp.each_packet do |pkt|
  if pkt.ip?
    puts "#{pkt.ip_dst}"
  end
end



require 'rubygems'
require 'pcaprub'
require 'pp'

# Open file capture
# Show me all SYN packets:
#bpffilter = "tcp[13] & 2 != 0"

require 'pp'
filename = './Example.pcap'
capture = PCAPRUB::Pcap.open_offline(filename)
puts "PCAP.h Version #{capture.pcap_major_version}.#{capture.pcap_minor_version}"
capture.each do |pkt|
  puts(capture.stats())
  #if pkt.ip?
  #   puts "#{pkt.ip_dst}" 
  #end
  pp pkt
end


# Capture interface 
capture = PCAPRUB::Pcap.open_live('lo', 65535, true, 0)
capture.setfilter('icmp')
capture.each_packet do |pkt|
  #puts(capture.stats())
  #pkt = capture.next()
  #if pkt.ip?
  #   puts "#{pkt.ip_dst}" 
  #end
  pkt.methods
end

# Capture interface example 2

  require 'pcaprub'
  SNAPLENGTH = 65535
  capture = PCAPRUB::Pcap.open_live('wlp3s0', SNAPLENGTH, true, 0)
  capture.setfilter('port 80')

  capture_packets = 10
  capture.each_packet do |packet|
    puts packet.class
    puts Time.at(packet.time)
    puts "micro => #{packet.microsec}"
    puts "Packet Length => #{packet.length}"
    p packet.data
    
    capture_packets -= 1
    if capture_packets == 0
      break
    end
  end  

  
== Using the Packet Dump Capabilities
Write to file Example.pcap the first 10 packets on eth0.

  require 'pcaprub'
  SNAPLENGTH = 65535
  capture = PCAPRUB::Pcap.open_live('wlp3s0', SNAPLENGTH, true, 0)
  dumper = capture.dump_open('./Example.pcap')

  capture_packets = 100
  capture.each do |packet|
    capture.dump(packet.length, packet.length, packet)
    puts "PACKETID: #{capture_packets}"
    capture_packets -= 1
    if capture_packets == 0
      break
    end
  end
  
  capture.dump_close
  
    
