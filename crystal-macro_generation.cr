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
