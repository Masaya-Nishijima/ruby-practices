#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/argument'
require './lib/file_list'
FileList.new(Argument.new).print_ls
