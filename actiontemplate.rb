require 'pp'

class SimpleUser

  def template?(name, obj)
    data = obj.new
    actiontemplate = { 'userdata' => { 
            'type' => "#{data.type}",
            'group' => "#{data.group}",
            'password' => "#{data.password}"
          }
    }
    puts "Action template User data"
    puts "User: #{name}"
    puts "Type: #{actiontemplate["userdata"]["type"]}"
    puts "Group: #{actiontemplate["userdata"]["group"]}"
    puts "Password: #{actiontemplate["userdata"]["password"]}"
  end

  def objtemplate(inherit, type, group, password)                                                                                                      
    asplat = Class.new(inherit) do
      attr_reader :type, :group, :password
      
        define_method :initialize do
          @type = "#{type}"
          @group = "#{group}"
          @password = "#{password}"
        end
        #if self.public_method_defined?("addwebuser")
        self.instance_methods(false).each do |m|
          puts "Added method #{m} from #{self}"
        end
        #end
    end
  end

end

class WebGUI
  
  attr_reader :usertype, :inherited_class
  
  def addwebuser
    @usertype = "guest"
    puts "WebGUI: Added usertype: #{@usertype}"
  end

  self.instance_methods(false).each do |m|
    puts "Added method #{m} from #{self}"
  end

end

obj = SimpleUser.new
asplat = obj.objtemplate(WebGUI, "adduser", "users", "203ufgjsg")
obj.template?("brian", asplat)
