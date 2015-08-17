# ====================
#  a858.rb
#  
#  Copyright 2015 Bri In The Sky <brian@orville>
#
# 
 
require 'pp'
require 'getoptlong'

ARGV[0] = "--help" if ARGV[0] == nil

opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--shift', '-s', GetoptLong::REQUIRED_ARGUMENT],
  [ '--func', '-f', GetoptLong::REQUIRED_ARGUMENT],
  [ '--words', '-w', GetoptLong::REQUIRED_ARGUMENT],
  [ '--type', '-t', GetoptLong::OPTIONAL_ARGUMENT]
)

opts.each do |opt, arg|
  case opt
    when '--help'
      helper = "\e[1;34mA858\e[0m\ \n"
      helper << "\e[1;34m=================================\e[0m\ "
      helper << %q[
-h, --help:
   show help

-s, --shift
    Value to shift base code

-f, --func
    Mathematical function to use
    
    addition
    subtract
    multiply
    divide

-t, --type
    Baseshift Return value in
    
    chr, ord, hex

-w, --words
    Words to process
    
 ]
      puts helper
      exit
    when '--shift'
      @shift = arg.to_i
    when '--func'
      @func = arg.to_s
    when '--type'
      @type = arg.to_s
    when '--words'
      @wordsnum = arg.to_i
  end
end

class A858

  def initialize
    @twochar_col = Array.new
    @dehex_col = Array.new
    @chr_col = Array.new
    @baseshift = Array.new
    @debug = 0
  end

  def self.define_component(name)
    name_func = name.to_s.split("_")[1].to_sym
    define_method(name) do |val|  
      (val).send("#{name_func}")
    end
  end

  define_component :convert_hex
  define_component :convert_chr
  define_component :convert_ord
  
  def baseshift(val, shift, func, type="chr")
    puts "Params: #{val} Shift: #{shift} Func: #{func} Type: #{type}" if @debug > 2
    if func == "subtract"
      a = val - shift
    elsif func == "addition"
      a = val + shift
    elsif func == "divide"
      a = val / shift
    elsif func == "multiply"
      a = val * shift
    end
    puts "A Value: #{a}" if @debug > 3
    # Return Type
    begin
      case type
      when "chr"
        return a.chr
      when "ord"
        return a.ord
      when "hex"
        return a.hex
      end
    rescue RangeError => e
      #pp e
    end
  end
  
  def decode(str, wordsnum, shift, func, type="chr")
    mdtuples = str.split(" ")
    twochar = String.new
    c = 0
    print "Twochar:"
    mdtuples.each {|n| # 32 Char strings of which last is 16
      n.split("").each {|m|
        twochar << m
        if twochar.size == 2
          print " #{twochar}"
          @twochar_col << twochar
          @dehex_col << convert_hex("#{twochar}")
          @chr_col << convert_chr(convert_hex("#{twochar}"))
          @baseshift << baseshift(convert_hex("#{twochar}"), shift, func, type)
          twochar = ""
        end
      }
      if c == wordsnum
        break;
      end
      c += 1
    }
    puts "\n\nMDTuples: #{mdtuples.size}"
    puts "Two Char: #{@twochar_col}"
    puts "Dehex Char: #{@dehex_col}"
    puts "Chr: #{@chr_col}"
    puts "Baseshift Char: #{@baseshift}"
  end

end

str = "c409c8b91c7910f220ee4981b8df77c4 330dc24548f60c7e00cdcffd971d9ff6 62aab227bf0763900cb3d02a782a1fbb 121a181b6b7a36bb9113c48ed074a8d8 d9bbc89c25018ae1a274b0e660425eb0 fbd42e509a39e767191e6b3b690acaa1 07f8e1f3ae09416e8db60431d1267772 5e571af000d64fd4be6f16e97eab2b7a 3b023dbc640f9e39f0c69a268dcf29b1 ebc6895e8d9ec5e93e57f90efa236d12 e6090053978596e5b632795374df33a7 4f71c3077ceef9e39a3e6088ff2500c8 b73d0d3f17823d88d17e86bbca9b89da 60ff75ac2c022bc916b012bc5065e3c9 b3ca5dba8cbc44facf48999063375750 75d998d66f97f728d6aa8065feefe9dc 6174ae7a779df9ac090c73a7c9ca6581 8c94f5007c74d05ed216531da5b2384e d5d5ca57105b3ff4bceda29131e4ae61 32028e032cdec447fcbf6a9334c07400 483a79c0d62a0dfdca17ae2fd92b9a1a 7189f6aea57ffc4465b401a23bfe090b 5dd473722844c62e98d3087d4007bc20 896aa7dadf5b8c9767b93454feb32096 fbe111d30f80cd323bb9697bd087ea73 39dff0311ea3653d2b3ac900d88e2b81 2864adb1ae7e42de41485a6975c1c9d6 b2a2135b7b0281e302d23a30b1cecc4c 2273a3e7b5c8e95ae389522559b67288 7d5b30a0fc680f2f320401f6f56fa404 339fa2dac85f195226f6e4b28cd5912d 89904fe00f7695cd2b9c99b3f24e49aa a6f1bc0ef185349327dc445016e88496 f8002438417d636955f1460cb5d5c2a2 92031efb30dbfab3124eaa91110ce23b 8da06a2ac2fc470c0ccf0d2a7b77229c 15bac0911383634024b489fca31f06e8 27d60deee61106092d8d6be78bcbea98 1b330503620f8053495429a6a71c8a73 9ec39f0b67cb3177121c8fb467d849c8 c24fbb4d8e463aa85aa8c0aaa9be1670 35df218ae2ced8d55ac62207e92218dd e97e813d396b50953d2d653ec3f63b79 8c5f21691a26ebb6bfd9cf6844f4f5a1 4ada5281bba1889fa5e67c88ba5dd45b c908028b0a693eb68c553298dc2f9d26 02f071227abda5d470ce836f3e2a1c0d 58bf22fc7be6dae18229d10867489d53 d5b6b110f0b40b01ebb772a29b17c9b7 f96be237d32c9fd4b4c9795b1ee7fb1b f652dbbcecdf4879fda5b8904d96986f 032265f40c0c1b35399e3023b6ced970 7cf44639a4a74b18287fcfff467952e3 59d1520125bc9cae95bda1fa58780582 df61ab78d59825217be807323aef86c5 dcf3831dc7eb27444946e2573f3e7531 984c68853ca713f488546b0f0a936eeb bfd3734468581f66793a7029a910264e 421070c2a7e319563dda0d4be3b9603c 984aa422b005626ebdcea952afc7a597 0152f48330df6f4e545b502d0761ccaa 5deab317c11b399d56ede7a38cf26a33 f2f5783413d66cb591bd0157183d9135 aa7d1a334d3e31d1337dcd72fca039d3 5df7987bd0735ec3dcb334ce88b5d707 ea3d86fcad844cc0dd4dc79a4ef4f4a9 2787ce9e61a6e9bf9f81884cb1cc2287 fd5d721890689b76efa19e99072dead4 867917a1920111066a44c3908efc4b6e f2da7e9cc4101295cd30802a636ade69 669d62c692c0d4a374324877fa67b65b 4f6fe0eee063a1f4c22283663c6177d0 72f57487d940db5abec61e2a313f01b1 7940cae770907d0598e97e7aa55973bf b40c74c4074ab0aa3afc79bd7e9d8bbc fa7704d500e6a51ce5194b54180a2d7a 7f53cb27712c0271f9b55b7bd7b9f111 8c92fe32aa9a937c5e388273a517f66f 9012498b443b79fbd945a76e1a4b9947 c11b0ddfa3c1b0a6af2974e10925a0c1 d216a1b757ef008fd7442f618ae9f573 b1222860ed614bd82054e63fc6eee8a4 70ba5e1bd140703f4650c06673a08ff9 5a1a6fad7c54f14bdcde3567c1d2ddfc e9b80b44a15b959f6e656f09bef9b5cf 9be0125b91b9d98a5702cde0dd4741d8 7c12b134a5980e80ff00c6aa5328e41b 81da1d135564f8ca6aa2d5f776b3073d 71888e5214b4fb3dfa7d6a7517c2124d 750cdf3cc131e0b6938192102871a2ea 38f8d6099683aff63dcfb7bd19daec79 ba9b05883ab2d5ed87d6c371eb8ccfb8 f1fe9b0c379aa5fe18a921938df4e013 560d3ec0018dd8513f75b7d0833411ad ae3cff80e1b61c807dc28f818ceb737d 5e211b902ce8ebfd10be66ff2e3a99bc 5b48d5333e98683ef27b72d28685151f 347c9bbce976a58249aa3afb68efcc62 b3bf94539c755c3374b5bca080700502 ff2ff1356a3978807eb0de9e8ef03267 3dc3b1eb8e6838c6183ec9c2685246fe a29a3392b03cc094a97650c06d096a04 7490fa29f5935808e196c9a77c9588d0 2a031ef36cfbd8b1c9dac93907f99788 dab8ec23fcae09f8a8c85f28ea49fb71 3728a7de99e360ca65d13e29454f799e bbb04e12475efd2b24f6d4985582e609 cca5f7bd7a6eb56b82b0a340339dc48e 7e0cb804900a0b82aef3d9a0e5d26d78 e23aaa59e993f7f4cc73c795b34c6083 e72279170768c7b0"
x = A858.new
x.decode(str, @wordsnum, @shift, @func)
