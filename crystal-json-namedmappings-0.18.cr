require "json"

struct Point
  JSON.mapping x: Int32, y: Int32
end

struct Circle
  JSON.mapping center: Int32, radius: Int32
end

class Result
  JSON.mapping shape: Point | Circle
end

result = Result.from_json(%({"shape": {"x": 1, "y": 2}}))
p result # => Result(@shape=Point(@x=1, @y=2))

result = Result.from_json(%({"shape": {"radius": 1, "center": 2}}))
p result # => Result(@shape=Circle(@center=2, @radius=1))

shapes = Array(Point | Circle).from_json(%([{"x": 1, "y": 2},
  {"radius": 1, "center": 2}]))
p shapes # => [Point(@x=1, @y=2), Circle(@center=2, @radius=1)]
