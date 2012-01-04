#!/usr/bin/env ruby

require 'puppet/face/completion'

args = ENV["COMP_LINE"].split /\s+/

# "puppet"
args.shift

choices, search_pattern = Puppet::Face[:completion, :current].bash(*args)
puts `compgen -W '#{choices.join(" ")}' -- '#{search_pattern}'` if search_pattern

exit 0
