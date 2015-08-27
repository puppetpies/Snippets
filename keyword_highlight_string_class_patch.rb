class String

    def self.reset_colors
      puts "\e[0m\ "
    end

    def word_highlight
      begin
        keywords
        cpicker = [2,3,4,1,7,5,6]
        @highlight_keywords.each {|n|
          self.gsub!("#{n}", "\e[4;3#{cpicker[rand(cpicker.size)]}m#{n}\e[0m\ \e[0;32m".strip)
        }
        return self
      rescue
        puts %Q{ERROR:\n
Example:\n
def "#{self}".keywords
  @highlight_keywords = ["Linux", "MyClass", "Ruby"]
end
"#{self}".word_highlight
}

      end
    end
    
end


sentence = "Linux with Ruby and MyClass changes"
def sentence.keywords
  @highlight_keywords = ["Linux", "MyClass", "Ruby"]
end
puts sentence.word_highlight

String.reset_colors

puts "Hello mum"

sentence2 = "Will Daddy stop shouting"
def sentence2.keywords
  @highlight_keywords = ["Daddy", "shouting", "Ruby"]
end
puts sentence2.word_highlight

String.reset_colors

class String

  def keywords
    @highlight_keywords = ["Global", "Across", "All", "Strings"]
  end

end


puts "Just a test for Global Across All of my Strings".word_highlight

String.reset_colors
