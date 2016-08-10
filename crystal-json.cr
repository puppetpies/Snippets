require "json"

json = String.build do |io|
  io.json_object do |object|
    object.field "id", "int"
    object.field "name", "varchar"
    object.field "guid", "char(36)"
  end
end

p json

parser = JSON.parse(json)
parser.each { |k, v|
  puts "#{k} #{v}"
}
        
# icr(0.18.6) > 
# icr(0.18.6) > p parser
# {"id" => "int", "name" => "varchar", "guid" => "char(36)"}
#  => {"id" => "int", "name" => "varchar", "guid" => "char(36)"}
# icr(0.18.6) > parser.class
#  => JSON::Any
