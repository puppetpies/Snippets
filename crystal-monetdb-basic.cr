@[Link("mapi")]
lib MonetDBMAPI
  type Mapi = Void*
  type Mapihdl = Void*
  alias Mapimsg = LibC::Int
  fun mapi_connect(host : LibC::Char*, port : LibC::Int, username : LibC::Char*, password : LibC::Char*, lang : LibC::Char*, dbname : LibC::Char*) : Mapi
  fun mapi_query(mid : Mapi, cmd : LibC::Char*) : Mapihdl
  fun mapi_disconnect(mid : Mapi) : Mapimsg
end

class MonetDB
  property? mid : MonetDBMAPI::Mapi
  property host, port, username, password, lang, db

  def initialize
    @host = "127.0.0.1"
    @port = 50000
    @username = "monetdb"
    @password = "monetdb"
    @lang = "sql"
    @db = "test"
    @mid = connect
  end
  
  def connect
    @mid = MonetDBMAPI.mapi_connect(@host, @port, @username, @password, @lang, @db)
  end
  
  def query(cmd : String)
    MonetDBMAPI.mapi_query(@mid, cmd)
  end
  
  def disconnect
    MonetDBMAPI.mapi_disconnect(@mid)
  end
end
m = MonetDB.new
m.host = "172.17.0.2"
m.username = "monetdb"
m.password = "monetdb"
m.db = "threatmonitor";
m.connect
m.query("SELECT 1;")
m.disconnect
