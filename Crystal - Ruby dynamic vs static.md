# Crystal - Ruby Dynamic vs Static

The main difference between Ruby and Crystal is Ruby is a dynamic interpreted language and
Crystal is a compiled and statically typed language, oh and everythings an object.

If you remember the Stopwatch class which has define component which is a runtime dynamic
feature Ruby creates these functions at runtime.

```ruby
class Stopwatch

  attr_reader :t1, :t2
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
  
  private
  
  def intervalh
    t1h, t2h, @calc = Time.at(@t1), Time.at(@t2), round_to(@t2 - @t1, 2)
  end
  
  protected
  
  def timestamp; Time.now.to_f; end
  
  public
  
  def watch(method)
    if method == "start"
      @t1 = timestamp
    elsif method == "stop"
      @t2 = timestamp
    intervalh
  end
  
  end
  
end
```

In Crystal you can create what looks like dynamic code but its actually just a macro language
where the code gets expanded into real code before compilation.

```crystal
class Test
  {% for method in %w(len digits scale table name type query) %}
  def get_{{ method.id }}(hdr)
    case hdr
    when "len", "scale"
      puts "Len or Scale: #{hdr}"
    else
      puts "Everything else: #{hdr}"
    end
  end
  {% end %}
end
Test.new.get_len("len")
Test.new.get_scale("scale")
Test.new.get_digits("We are digits")

[brian@orville ~]$ crystal run macro_test.cr 
Len or Scale: len
Len or Scale: scale
Everything else: We are digits
```

You can also patch existing namespaces / classes that exist but you can't add new defs/functions
after runtime so you could do.

```crystal
[brian@orville pcap.cr]$ icr
icr(0.18.6) > module Mynames
icr(0.18.6) > class Addressbook
icr(0.18.6) > def firstname(name)
icr(0.18.6) > puts "Firstname: #{name}"
icr(0.18.6) > end
icr(0.18.6) >
icr(0.18.6) > def lastname(name)
icr(0.18.6) > puts "Lastname: #{name}"
icr(0.18.6) > end

icr(0.18.6) > end
icr(0.18.6) > end
=> ok
icr(0.18.6) >
icr(0.18.6) > module Mynames
icr(0.18.6) > class Addressbook
icr(0.18.6) > def firstname(name)
icr(0.18.6) > puts "Firstname: #{name}: New version of def"
icr(0.18.6) > end
icr(0.18.6) > end
icr(0.18.6) > end
=> ok
icr(0.18.6) > Mynames::Addressbook.new.firstname("test")
Firstname: test: New version of def
=> nil
icr(0.18.6) >
```

We also support an interesting feature of overloads when you can have the same function with different parameters like in
functional languages.

```crystal
[brian@orville ~]$ icr
icr(0.18.6) > def watch(str : String, message : String, switch : Bool)
icr(0.18.6) >   if switch == true
icr(0.18.6) >     puts "#{watch}: #{message}"
icr(0.18.6) >   else
icr(0.18.6) >     puts "#{watch}: #{bool}"
icr(0.18.6) >   end
icr(0.18.6) >   end
 => ok
icr(0.18.6) > def watch(str : String)
icr(0.18.6) >   puts str
icr(0.18.6) >   end
 => ok
icr(0.18.6) > watch(Bool)
Error in ./.icr_1xOR8YLxRNGeObw482In3Q.cr:16: instantiating '__icr_exec__()'

puts "|||YIH22hSkVQN|||#{__icr_exec__.inspect}"
                         ^~~~~~~~~~~~

in ./.icr_1xOR8YLxRNGeObw482In3Q.cr:13: no overload matches 'watch' with type Bool:Class
Overloads are:
 - watch(str : String, message : String, switch : Bool)
 - watch(str : String)

  watch(Bool)
  ^~~~~
```
the above didn't work because it accepts
```crystal
 - watch(str : String, message : String, switch : Bool)
 - watch(str : String)

# However these work fine as all the types and number of parameters also matched.
icr(0.18.6) > watch("Brian")
Brian
 => nil
icr(0.18.6) > watch("Brian", "Morning", true)
Morning : true
 => nil
```

The reason you can't add new functions is because the binary has already been built and you can't just add new features 
to the binary when you think about it without recompilation.

You might ask how has somebody created Crystal icr or interactive Crystal as shown above that
because it compiles every class after you paste it in and it takes a few seconds.
So the use cases for the Crystal language is quite simple if you don't need dynamic methods
created on the fly or want to eval lots of code or inject code in places you could just as easily
make it in Crystal it depends on your use case.

## Crystal has,

Monkeypatching so you can patch existing methods

Macros so you can create a little bit what looks like dynamic code but is built before compilation.

We also have &block / yield

Crystal has Shards there like Gems but we prefer to use github.

Crystal is designed to be a modern C like language but with Ruby inspired syntax.

Crystal is compiled under LLVM so its very fast and the binaries are very small because of dynamic linking.

Some Crystal code is compatable with Ruby and vice versa mainly simple programs

Crystal can talk to C libraries and you don't have the annoyance of creating Gems with external bindings and header files.

# This is all you would need to make MonetDB work in a very basic form after installing the client libraries 

## These are required for the dynamic linking / compilation.

```crystal
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
m.host = "localhost"
m.username = "monetdb"
m.password = "monetdb"
m.db = "test";
m.connect
p m
m.query("SELECT 1;")
m.disconnect
```

## Conclusion.

Yes Ruby can do so much more far more in its dynamic way but are you willing to sacrifice maybe 30x to 1000x the performance.

You can convert your program from Ruby to Crystal pretty easily so testing it might not be that hard.

Crystal has loads of modern features out of the box like OAuth a JSON API, XML, HTTP Server / Client library, CSV parser to name some.

Crystal has only been around 3 years and has MySQL / Postgres and Message queue shards made by community members.

You get the benefits of C performance but code it like a high level language i can't think of anywhere thats been done before.

## Links
http://carc.in - Try you Ruby code in Crystal on your web browser

http://crystal-lang.org

Follow me on Twitter / Github - http://twitter.com/puppetpies,  http://github.com/puppetpies

Bye for now !

Brian Hood
