class Object 
  macro alias_method(new, old) 
    def {{new}}(*args, **kwargs) 
      {{old}}(*args, **kwargs) 
    end 
  end 
end 
