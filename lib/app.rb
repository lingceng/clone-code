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
            tmp = IO.read(from)

            tmp = @replacer.sub(tmp)

            File.open(to, 'w') do |rfile| 
                rfile.puts tmp
            end
        end
    end

    def run()
        # capatible for windows path
        @opt.directory.gsub!('\\', '/')
        # whether replace quietly
        all = false

        Dir[@opt.directory].each do |f|
            puts "do with [#{f}]"  

            rf = @replacer.sub(f)

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
                    if  all
                        puts "replace [#{f}] to file [#{rf}]"
                        subfile(f, rf)
                    else
                        puts "warning: [#{rf}] existed, y(es)/all/no, default is #{@opt.confirm}?" 
                        cmd = gets
                        cmd = @opt.confirm if cmd.strip.empty?
                        
                        if cmd == "all"
                          all = true
                        end

                        if cmd == "yes" || cmd == "y" || cmd == "all"
                            puts "replace [#{f}] to file [#{rf}]"
                            subfile(f, rf)
                        end
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


