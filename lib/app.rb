require 'fileutils'
require 'lib/replacer'

#
# file recursive
#
class App
    def initialize(options) 
        @opt = options;

        # capatible for windows path
        @opt.directory.gsub!('\\', '/')
        @opt.from.gsub!('\\', '/')
        @opt.to.gsub!('\\', '/')

        @opt.comfirm ||= "no"
        @opt.folder ||= ""
        @opt.folder.gsub!('\\', '/')


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
        # whether replace quietly
        all = false

        append_point = unless @opt.folder.empty?
          arr = @opt.folder.split("/")
          arr[0] if arr.size >= 2
        end

        Dir[@opt.directory].each do |f|
            puts "do with [#{f}]"  

            rf = @replacer.sub(f)
            rf.sub!(append_point, @opt.folder) if append_point

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
                        cmd = gets.strip
                        cmd = @opt.confirm if cmd.empty?
                        
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


