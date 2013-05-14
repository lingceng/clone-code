require 'fileutils'
require 'lib/replacer'

#
# file recursive
#
class App
    def initialize(options) 
        @opt = options;
        @replacer = Replacer.new(options.from, options.to)
    end

    def subfile(from, to)

        if @opt.rename
            FileUtils.copy(from, to);
        else
            File.open(to, 'w') do |rfile| 

                File.foreach(from) do |line|
                    # do replace
                    rfile.puts @replacer.sub(line) 
                end
            end
        end
    end

    def run()
        # capatible for windows path
        @opt.directory.gsub!('\\', '/');

        Dir[@opt.directory].each do |f|
            puts "do with [#{f}]"  

            rf = @replacer.sub(f)
            rf = f + '_replaced' if f == rf
           

            # create file dir if not exist
            if File.directory?(f) 
               if Dir.exist?(rf) 
                    puts "folder [#{rf}] existed and ignored"  if @opt.verbose
               else
                   puts "mkdir [#{rf}]"
                   FileUtils.mkpath(rf) 

               end
            else 
                if File.exist?(rf) 
                    puts "warning: [#{rf}] existed, yes to override [no]?"
                    cmd = gets
                    if cmd.chomp == "yes"
                        subfile(f, rf)
                    end
                else
		                FileUtils.mkpath(File.dirname(rf)) 
                    puts "replace [#{f}] to file [#{rf}]"
                    subfile(f, rf)
                end
            # end of if directory
            end 

        end
    end
end


