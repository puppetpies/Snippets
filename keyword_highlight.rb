a = "Linux, Android, some text Java Mobile hello this is just a test, DevOps, far to much fun!"

def text_highlighter(text)
  keys = ["Linux", "Java", "Android", "DevOps", "obi", "uc", "un!", "us"]
  cpicker = [2,3,4,1,3]
  keys.each {|n|
    text.gsub!("#{n}", "\e[4;3#{cpicker[rand(cpicker.size)]}m#{n}\e[0m\ ".strip)
  }
  puts text
end

10.times {
  text_highlighter(a)
}
