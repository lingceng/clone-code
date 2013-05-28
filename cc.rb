# encoding: utf-8

$:.unshift File.dirname(__FILE__) + "/"

require 'optparse'
require 'ostruct'
require 'lib/app'


options = OpenStruct.new
parser = OptionParser.new do |opts|
  opts.version = "1.4"
  opts.banner = <<EOS
Usage: launch.rb [options]
eg. launch.rb -f HellWorld -t WellDone -d 'HelloWorld/**/*'

EOS


  opts.on("-f", "--from FROM", "FROM string to replace") do |from|
    options.from = from
  end

  opts.on("-t", "--to TO", "TO string to replace") do |to|
    options.to = to
  end

  opts.on("-d", "--dir DIR", "DIR pattern to replace", 
          "eg. 'hello/**/*.java'") do |v|
    options.directory = v
  end

  opts.on("-r", "--[no-]rename", "Just rename and copy content") do |v|
    options.rename = v
  end

  opts.on("-v", "--[no-]verbose", "Run verbosely, default false") do |v|
    options.verbose = v
  end
end

parser.parse!(ARGV)

if options.verbose
    puts "start replacer..."
    p options
    #p ARGV
end


if options.from && options.to  && options.directory
    app = App.new(options)
    app.run
else
    puts parser.help
end

puts "replacer stopped" if options.verbose
