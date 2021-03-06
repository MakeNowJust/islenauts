#!/usr/bin/env ruby
#         _
# o      | |
#     ,  | |  _   _  _    __,        _|_  ,
# |  / \_|/  |/  / |/ |  /  |  |   |  |  / \_
# |_/ \/ |__/|__/  |  |_/\_/|_/ \_/|_/|_/ \/
#
# README.md generater
# $ ./script/README.md.rb > README.md

require 'erb'

palette = File.read("palette.toml")
  .split(/\n/)
  .reject{|line| line =~ /^\s*$|^#/}
  .map{|line| line.split(/=/).map(&:strip).tap{|e|e[1]=e[1][1..-2]}}
  .map{|name, color| ["http://placehold.it/16x16/#{ color[1..-1]}?text=%20", name, color] }

palette_size = palette[0].size.times.to_a.map{|i| palette.map{|x|x[i].size}.max}

print ERB.new(DATA.read).result(binding)

__END__
# islenauts

![islenauts logo](https://raw.githubusercontent.com/MakeNowJust/islenauts/master/logo/islenauts.png)

islenauts is a color set for anything.


## palette

| <%= "#".center(5 + palette_size[0] + palette_size[1]) %> | <%= "name".center(palette_size[1]) %> | <%= "RGB".center(2 + palette_size[2]) %> |
|:<%= "-" * (5 + palette_size[0] + palette_size[1]) %>:|:<%= "-" * palette_size[1] %>:|:<%= "-" * (2 + palette_size[2]) %>:|
<% palette.each do |url, name, color| %>| ![<%= name.ljust(palette_size[1]) %>](<%= url %>) | <%= name.center(palette_size[1]) %> | `<%= color.center(palette_size[2]) %>` |
<% end %>

## author

TSUYUSATO Kitsune <mailto:make.just.on@gmail.com>

## license

This software is licensed under the CC0. [![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/)
