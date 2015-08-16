#!/usr/bin/env ruby
#         _
# o      | |
#     ,  | |  _   _  _    __,        _|_  ,
# |  / \_|/  |/  / |/ |  /  |  |   |  |  / \_
# |_/ \/ |__/|__/  |  |_/\_/|_/ \_/|_/|_/ \/
#
# Show colors in your terminal
# $ ./script/show_in_terminal.rb      # 8bit color mode
# $ ./script/show_in_terminal.rb true # 24bit true color mode

true_color = ARGV[0] == "true"

palette = File.read("palette.toml")
  .split(/\n/)
  .reject{|line| line =~ /^\s*$|^#/}
  .map{|line| line.split(/=/).map(&:strip).tap{|e|e[1]=e[1][1..-2]}}

def rgb_to_256(color)
  r = color[1..2].to_i(16) * 6 / 256
  g = color[3..4].to_i(16) * 6 / 256
  b = color[5..6].to_i(16) * 6 / 256

  return r * 36 + g * 6 + b + 16
end

max_len = palette.map{|name,*|name.size}.max

palette.each do |name, color|
  unless true_color
    puts "#{name.ljust max_len} : \e[48;5;#{rgb_to_256 color}m #{color} \e[0;38;5;#{rgb_to_256 color}m #{color} #{rgb_to_256 color} \e[0m"
  else
    rgb = color[1..-1].scan(/../).map{|c|c.to_i 16}.join ";"
    puts "#{name.ljust max_len} : \e[48;2;#{rgb}m #{color} \e[0;38;2;#{rgb}m #{color} \e[0m"
  end
end
