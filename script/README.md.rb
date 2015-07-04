#!/usr/bin/env ruby

# README.md generater
# ./script/README.md.rb > README.md

require 'erb'

palette = File.read("palette.toml")
  .split(/\n/)
  .map{|line| line.split(/=/).map(&:strip).tap{|e|e[1]=e[1][1..-2]}}

print ERB.new(DATA.read).result(binding)

__END__
# islenauts

islenauts is a color set for anything.


## palette

| name | # | RGB |
|:----:|---|:---:|
<% palette.each do |name, color| %>| <%= name %> | ![<%= name %>](http://placehold.it/16x16/<%= color[1..-1] %>?text=%20) | `<%= color %>` |
<% end %>


## author

TSUYUSATO Kitsune <mailto:make.just.on@gmail.com>

## license

This software is licensed under the CC0. [![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/)
