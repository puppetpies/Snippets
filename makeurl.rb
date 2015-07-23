
#headers = %Q{Request Data: GET /favicon.ico HTTP/1.1
#Host: bank-38.ads.mp.mydas.mobi
#}

headers = %Q{[root@orville Examples]# ruby http_capture.rb 
Request Data: GET /cmremoteconfig/default HTTP/1.1
Host: pancake.apple.com
Accept-Encoding: gzip
Accept: */*
Accept-Language: en-gb
Cookie: POD=gb~en; s_fid=0E2B7BBC36919556-19509290CC0DA05F; s_vi=[CS]v1|2AD4BED1850117A9-40000103800ECCB3[CE]; s_vnum_n2_us=4%7C1%2C19%7C1
Connection: keep-alive
User-Agent: AppleCoreMedia/1.0.0.12F70 (iPhone; U; CPU OS 8_3 like Mac OS X; en_gb)}

host, request = ""
headers.each_line {|n|
  if n.split(":")[0] == "Host"
    host = n.split(":")[1].strip
  elsif n.split(":")[0] == "Request Data"
    request = n.split(":")[1].split(" ")[1]
  end
}
puts "http://#{host}#{request}"
