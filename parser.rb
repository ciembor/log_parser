#!/usr/bin/env ruby

require_relative 'services/log_parser.rb'

log_parser = LogParser.new(ARGV.first)
log_parser.perform
