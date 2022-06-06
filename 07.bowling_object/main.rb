#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/game'
require './lib/frame'
require './lib/shot'

puts Game.new(ARGV.first).score
