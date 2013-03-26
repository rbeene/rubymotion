#!/usr/bin/env ruby
require 'optparse'
require 'find'
require 'FileUtils'

options = {}
option_parser = OptionParser.new do |opts|
  # Create a switch
  opts.on("-c","--clean") do 
    options[:clean] = true
  end
end
option_parser.parse!
here = File.expand_path(File.dirname(__FILE__))

if options[:clean] == true
  Find.find(here) do |path|
    if File.basename(path) == 'build'
      p path
      FileUtils.remove_dir(path, true)
      Find.prune
      puts "Files removed"
    end
  end
  exit
end

Find.find(here) do |path|
  if File.basename(path) == 'Rakefile'
    command = "cd #{File.dirname(path)}; rake build"
    p command
    system(command)
  end
end
