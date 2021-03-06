# encoding: utf-8


require 'optparse'
require 'ostruct'
require 'yaml'
require_relative 'lib/app'


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

  opts.on("-y", "--yml YAML", "YAML configuire file", 
          "eg. -y task.yml") do |v|
    options.yml = v
  end

  opts.on("-r", "--[no-]rename", "Just rename and copy content") do |v|
    options.rename = v
  end

  opts.on("-q", "--confirm DEF", "Set default action when target dir exists, yes/all/no") do |v|
    options.confirm = v
  end

  opts.on("-p", "--append FOLDER", "Append folder after specific path.", 
          "eg. to add 'hi' foler after 'doc' use -p doc/hi") do |v|
    options.folder = v 
  end

  opts.on("-v", "--[no-]verbose", "Run verbosely, default false") do |v|
    options.verbose = v
  end
end

parser.parse!(ARGV)

if options.verbose
    puts "start replacer..."
    p options
end


if options.yml
  conf = YAML.load_file(options.yml)

  opts = OpenStruct.new(conf)
  app = App.new(opts)
  for item in opts.path
    app.clone(item)
  end 

elsif options.from && options.to  && options.directory
  app = App.new(options)
  app.clone(options.directory)
else
  puts parser.help
end

puts "replacer stopped" if options.verbose
