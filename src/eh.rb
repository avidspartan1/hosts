#!/usr/bin/env ruby
#
# The etc hostess (/etc/hosts)
#
# Modifies and/or parses /etc/hosts. See --help for more info.
#
require 'optparse'
require 'pathname'
require 'resolv'

options = {
  verbose: false,
  target: '/etc/hosts',
  mode: 'write',
}

OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-v", "--verbose", "Display verbose output.") do
    options[:verbose] = true
  end

  opts.on("-t", "--target FILE", "The file to read from and/or modify.") do |f|
    unless File.file?(f)
      raise "ERROR: target file #{f} is not accessible."
    else
      options[:target] = f
    end
  end

  opts.on("-m", "--mode MODE", "The mode of etc hostess. Can be [report|write].") do |m|
    unless m =~ %r{^(report|write)$}
      raise "ERROR: invalid mode. Must be one of [report|write]."
    else
      options[:mode] = m
    end
  end
end.parse!

puts "Options: \n#{options}" if options[:verbose]

# Check permissions on the file
target_file = Pathname.new(options[:target])

raise "ERROR: file is not readable." if !target_file.readable?
raise "ERROR: file is not writable." if options[:mode] == 'write' && !target_file.writable?

def parse_hosts
  contents = target_file.read()

  hosts = {}
  n = 0
  contents.each_line do |line|
    n += 1
    items = line.split
    raise "ERROR: invalid hosts line detected: ##{n}" if items.length <= 1

    ipaddr = items[0]
    hnames = items[1..-1].sort

    raise "ERROR: " 
  end
end
