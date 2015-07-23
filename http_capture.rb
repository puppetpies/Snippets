#!/usr/bin/env ruby
require 'rubygems'
require 'pcaplet'

=begin
data = %Q{POST /pub/api.php?action=applicationRun&appBuild=813493&appId=95&appVersion=5.9&country=GB&currentTime=1435583909&deviceName=samsung%20GT-I8160&language=en&libVersion=3.3.1%3A5815&openUDID=938ae1e8fd90e10a644dc5c504ddc473&platform=Android&protocol=1.0&systemVersion=2.3.6&hash=17f12455fee69fda19d95635ab02c0e0 HTTP/1.1
User-Agent: MRGSHTTPRequest
ref: bdd097244832f3b2a60c11ddb9976275
action: applicationRun
Content-Length: 1466
Content-Type: multipart/form-data; boundary=Lw05lkVKD3lJpmdotDKGbrAbUNsLuMQJ0lh
Host: mrgs.my.com
Connection: Keep-Alive
}
=end

def makeurl(data)
  hdrs = data
  hostn, requestn = ""
  hdrs.each_line {|n|
    if n.split(":")[0] == "Host"
      hostn = n.split(":")[1].strip
    elsif n.split(" ")[0] == "GET"
      requestn = n.split(" ")[1]
    end
  }
  puts "\e[1;33mURL: http://#{hostn}#{requestn} \e[0m\ "
end

def filterdata(mtable, data)
  lkey, rkey = ""
  q = "q=#{mtable},"
  print "Influx Data: "
  t = 0
  data.each_line {|n|
    if t > 0 # Don't processes GET / POST Line
      lkey = n.split(":")[0].downcase.gsub("-", "").to_s.strip
      rkey = n.split(":")[1].to_s.strip
      q << "#{lkey}=#{rkey},"
    end
    t = t + 1
  }
  q = q[0..q.size - 2] # Detract comma
  q << " value=0"
  puts q
end

HTTP_METHODS = %r=^GET |^HEAD |^POST |^PUT |^TRACE |^CONNECT |^OPTIONS |^DELETE |^PROPFIND |^PROPPATCH |^MKCOL |^COPY |^MOVE |^LOCK |^UNLOCK =
httpdump = Pcaplet.new('-s 1500 -n -i wlo1')
HTTP_REQUEST  = Pcap::Filter.new('tcp dst port 80', httpdump.capture)
HTTP_RESPONSE = Pcap::Filter.new('tcp src portrange 1024-65535', httpdump.capture)

httpdump.add_filter(HTTP_REQUEST | HTTP_RESPONSE)
httpdump.each_packet {|pkt|
  data = pkt.tcp_data.to_s
  case pkt
  when HTTP_REQUEST
    if data =~ HTTP_METHODS
      path = $1
      host = pkt.dst.to_s
      host << ":#{pkt.dport}"
      s = "#{pkt.src}:#{pkt.sport} > GET http://#{host}#{path}".gsub("GET", "\e[1;36mGET\e[0m")
      puts "\e[1;31mRequest Data: #{data} \e[0m\ "
      makeurl(data)
      filterdata("starbucks", data)
    end
  when HTTP_RESPONSE
    if data =~ /^(HTTP\/.*)$/
      status = $1
      s = "#{pkt.dst}:#{pkt.dport} < #{status}"
      puts "\e[1;32mResponse Data: #{data} \e[0m\ "
      #makeurl(data)
    end
  end
  puts s if s
}
