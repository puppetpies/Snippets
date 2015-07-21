#!/usr/bin/ruby

########################################################################
#                                                                      #
# Author: Brian Hood                                                   #
# Description: Influx Bench                                            #
#                                                                      #
#   Feel free to contribute more to this script / fork                 #
#                                                                      #
########################################################################

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

require "net/http"
require "uri"
require "json"
require "pp"
require "guid"
require 'getoptlong'

VERSION = "0.1.1"
MTABLE = "cpu" # Your test measurements table
OUTLIMIT = 50 # Limit the read output

ARGV[0] = "--help" if ARGV[0] == nil

opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--iterations', '-i', GetoptLong::REQUIRED_ARGUMENT],
  [ '--chunksize', '-c', GetoptLong::REQUIRED_ARGUMENT],
  [ '--ommit', '-o', GetoptLong::OPTIONAL_ARGUMENT ]
)

opts.each do |opt, arg|
  case opt
    when '--help'
      helper = "\e[1;34mWelcome to Influx Bench Version #{VERSION}\e[0m\ \n"
      helper << "\e[1;34m=================================\e[0m\ "
      helper << %q[
-h, --help:
   show help

-i --iterations
    Iterations of to run
    
-c --chunksize
    Chunksize how many records per iteration
    
-o, -ommit 
    Ommit Select query output to provent total time skew

Example:
      
      ruby influxdb.rb -i 3 -c 250
      
      This will run 3x 250 record chunks with a total of 750 records being inserted into the database.
      
      Also using ommit will stop a flood of on screen data at the end of the write.]
      puts helper
      exit
    when '--iterations'
      @iterations = arg.to_i
    when '--chunksize'
      @chunksize = arg.to_i
    when '--ommit'
      @ommit = 1
  end
end

module NumTools

  def random_between(min, max); min+rand(max); end

  def self.define_component(name)
    name_func = name.to_s.gsub("_to", "").to_sym
    define_method(name) do |val, x|  
      (val * 10**x).send("#{name_func}").to_f / 10**x
    end
  end

  define_component :floor_to
  define_component :ceil_to
  define_component :round_to

end

class Stopwatch

  include NumTools

  attr_reader :t1, :t2, :roundvals

  private

  def initialize
    @roundvals = []
  end
  
  def intervalh
    round = round_to(@t2 - @t1, 2)
    t1h, t2h, @calc = Time.at(@t1), Time.at(@t2), round
    record(round)
  end

  protected

  def timestamp; Time.now.to_f; end

  public

  def record(round)
    @roundvals << round
  end
  
  def print_stats
    round = round_to(@t2 - @t1, 2)
    puts "Start: #{Time.at(@t1)} Finish: #{Time.at(@t2)} Total time: #{round}"
  end
  
  def watch(method)
    if method == "start"
      @t1 = timestamp
    elsif method == "stop"
      @t2 = timestamp
      intervalh
    end
  end

end

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
      #puts "InfluxDB SQL URL: #{@dburl}/query?db=#{@dbname}"
      uri = URI.parse("#{@dburl}/write?db=#{@dbname}")
      #puts "Request URI: #{uri}"
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_content_type("application/x-www-form-urlencoded")
      begin
        request.body = data unless data.empty?
        response = http.request(request)
        if response.code == "204" # Good response
          # Lets have to dots.
          print "."
        elsif response.code == "200" or response.code == "400" # 200 can be an error in some cases !!
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
# Total Time Stopwatch
@stwt = Stopwatch.new
@stwt.watch('start')
# Select query Stopwatch
@stw = Stopwatch.new
metrics = DatalayerLight::InfluxDB.new
metrics.dbhost = "172.17.0.2"
begin
  # Write measurements to InfluxDB
  a = ["server1", "server2", "server3"]
  b = ["us-north", "us-south", "us-east", "us-west"]
  guid = Guid.new # Per benchmark tag
  recordcount = 0
  @iterations.times {|m|
    @stw.watch('start')
    @chunksize.times {|n|
      host = a[rand(a.size)]
      region = b[rand(b.size)]
      value = rand(0.99)
      j = metrics.query("#{MTABLE},guid=#{guid},host=#{host},region=#{region} value=#{value}", 'w')
      recordcount = recordcount + 1
    }
    puts "#{recordcount} record where written to InfluxDB!"
    ontheclock = @stw.watch('stop')
    puts "Wall Time(s) seconds: #{ontheclock}"    
  }
rescue
  puts "Something went wrong exiting..."
end

begin
  # Read measurements from InfluxDB
  #  WHERE region = 'us-east' LIMIT #{OUTLIMIT}
  @str = Stopwatch.new
  @str.watch('start')
  j = metrics.query("SELECT * FROM #{MTABLE} WHERE guid = '#{guid}' LIMIT #{OUTLIMIT}", 'r')
  ontheclock = @str.watch('stop')
  if !defined?(@ommit)
    j["results"].each {|n|
      n["series"].each {|a|
        name = a["name"]
        tags = a["tags"]
        host = tags["host"]
        region = tags["region"]
        puts "Tags | Host: #{host} Region: #{region}"
        columns = a["columns"]
        values = a["values"]
        d = 0
        puts "Dataset"
        columns.each {|c|
          values.each {|v|
            print "#{columns[d]}: #{v[d]} "
            d = d + 1
            if d == 2; d = 0; print "\n"; end
          }
        }
        puts "Name: #{name} Columns: #{columns}\n\n"
      }
    }
  puts "Data output complete ! i am limited to #{OUTLIMIT} records in the code"
  else
    puts "Query output ommited"
  end
rescue
  puts "Unable to read data"
end
@stwt.watch('stop')

# Use at_exit for a good reason
at_exit {
  include NumTools
  mybench = @stw.roundvals
  min = mybench.min
  avg = mybench.inject{ |sum, el| sum + el }.to_f / mybench.size
  avground = round_to(avg, 2)
  max = mybench.max
  arrsize = mybench.size
  mybench2 = @str.roundvals
  puts "Select Query: #{mybench2}"
  puts "Insert Performance - Min: #{min} Avg: #{avground} Max: #{max} Arr Size: #{arrsize}"
  # Display Total Runtime
  @stwt.print_stats
}
