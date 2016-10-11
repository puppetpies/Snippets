# Crystal PG Example code

crystal eval 'require "./src/pg"; c = PQ::ConnInfo.new("172.17.0.8", "wire", "user", "password"); p c; conn = PG.connect(c); p conn'

PQ::ConnInfo(@host="172.17.0.8", @port=5432, @database="wire", @user="wire", @password="dk3rbi9L", @sslmode=:prefer)
#<PG::Connection:0x269ce40 @pq_conn=#<PQ::Connection:0x26b0f30 @soc=#<TCPSocket:fd 8>, @server_parameters={"application_name" => "crystal", "client_encoding" => "UTF8", "DateStyle" => "ISO, MDY", "integer_datetimes" => "on", "IntervalStyle" => "postgres", "is_superuser" => "off", "server_encoding" => "UTF8", "server_version" => "9.5.4", "session_authorization" => "wire", "standard_conforming_strings" => "on", "TimeZone" => "UTC"}, @notice_handler=#<Proc(PQ::Notice, Nil):0x45b610>, @notification_handler=#<Proc(PQ::Notification, Nil):0x45b620>, @pid=904, @secret=385815289, @conninfo=PQ::ConnInfo(@host="172.17.0.8", @port=5432, @database="wire", @user="wire", @password="dk3rbi9L", @sslmode=:prefer), @mutex=#<Mutex:0x26a17e0 @mutex_fiber=nil, @lock_count=0, @queue=nil>, @established=true>>

# Easy reading example

require "./src/pg"
conninfo = PQ::ConnInfo.new("172.17.0.8", "wire", "user", "password")
conn = PG.connect(conninfo)
p conn
