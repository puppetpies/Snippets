
#require 'yaml'

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

  attr_reader :t1, :t2

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

t = Stopwatch.new
t.watch("start")
sleep(t.random_between(2, 8))
result = t.watch("stop")
#puts YAML::dump(result)
