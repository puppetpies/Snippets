#!/usr/bin/ruby

########################################################################
#                                                                      #
# Author: Brian Hood                                                   #
# Description: DockerFish Automation                                   #
# Version: v0.1                                                        #
#                                                                      #
########################################################################

require "net/http"
require "uri"
require "json"
require "pp"

=begin

* Hostname was NOT found in DNS cache
*   Trying 172.17.0.2...
* Connected to 172.17.0.2 (172.17.0.2) port 8086 (#0)
> POST /write?db=threatmonitor HTTP/1.1
> User-Agent: curl/7.37.0
> Host: 172.17.0.2:8086
> Accept: */*
> Content-Length: 43
> Content-Type: application/x-www-form-urlencoded
> 
* upload completely sent off: 43 out of 43 bytes
< HTTP/1.1 204 No Content
HTTP/1.1 204 No Content
< Request-Id: 01be1a93-2e47-11e5-8087-000000000000
Request-Id: 01be1a93-2e47-11e5-8087-000000000000
< X-Influxdb-Version: 0.9.1
X-Influxdb-Version: 0.9.1
< Date: Sun, 19 Jul 2015 18:50:21 GMT
Date: Sun, 19 Jul 2015 18:50:21 GMT

< 
* Connection #0 to host 172.17.0.2 left intact

=end

module DatalayerLight

  class InfluxDB

    attr_accessor :dbhost, :dbuser, :dbpass, :dbport, :dburl

    def initialize
      @dbhost = "127.0.0.1"
      @dbuser = "threatmonitor"
      @dbpass = "dk3rbi9l"
      @dbport = 8086
      @dbname = "threatmonitor"
    end
    
    def apiget(sql)
      @dburl = "http://#{@dbhost}:#{@dbport}"
      sqlunicode = URI.encode(sql)
      puts "InfluxDB SQL URL: #{@dburl}/query?db=#{@dbname}&q=#{sqlunicode}"
      uri = URI.parse("#{@dburl}/query?db=#{@dbname}&q=#{sqlunicode}")
      puts "Request URI: #{uri}"
      http = Net::HTTP.new(uri.host, uri.port)
      begin
        response = http.request(Net::HTTP::Get.new(uri.request_uri))
        begin
          j = JSON.parse(response.body)
        rescue JSON::ParserError
          puts "Could not read JSON data"
        end
      rescue
        puts "Error retrieving data"
      end
    end
    
    def apipost(data)
      @dburl = "http://#{@dbhost}:#{@dbport}"
      puts "InfluxDB SQL URL: #{@dburl}/query?db=#{@dbname}"
      uri = URI.parse("#{@dburl}/write?db=#{@dbname}")
      puts "Request URI: #{uri}"
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_content_type("application/x-www-form-urlencoded")
      begin
        request.body = data unless data.empty?
        response = http.request(request)
        if response.code == 204 # Good response
          puts "OK"
        elsif response.code == 200 or response.code == 400 # 200 can be an error in some cases !!
          puts "Error code #{response.code}"
        end
      rescue
        puts "Error posting data"
      end
    end
    
    def query(sql, mode="r")
      if mode == "r"
        apiget("#{sql}")
      elsif mode == "w"
        apipost(sql)
      end
    end
    
  end

end

metrics = DatalayerLight::InfluxDB.new
metrics.dbhost = "172.17.0.2"

=begin

# Read measurements from InfluxDB
j = metrics.query("SELECT * FROM cpu", 'r')
puts j
puts j.class

=end

# Write measurements to InfluxDB
a = ["server1", "server2", "server3"]
b = ["us-north", "us-south", "us-east", "us-west"]
c = [0.50, 0.60, 0.80, 0.90]
1000.times {|n|
  host = a[rand(a.size)]
  region = b[rand(b.size)]
  value = c[rand(c.size)]
  j = metrics.query("cpu,host=#{host},region=#{region} value=#{value}", 'w')
}
