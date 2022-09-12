# frozen_string_literal: true

# Thor CLI compiler

require 'yaml'
require_relative 'builder'
require_relative 'interpreter'

Builder.new('commands.yml', 'test.rb').store!
