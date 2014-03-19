#
# replace module
#
class Replacer 

    def initialize(from, to)
        @from = from;
        @to = to;
    end

    def sub(str)
        # mornal sub, eg HelloWorld to WellDown
        @rstr = str.gsub(@from, @to)

        # variable sub, eg helloWorld to wellDown 
        @rstr.gsub!(uncapitalize(@from), uncapitalize(@to));
        # capitalize sub, eg helloWorld to wellDown 
        @rstr.gsub!(@from.capitalize, @to.capitalize);

        # underscore sub, eg hello_world to well_down 
        @rstr.gsub!(underscore(@from), underscore(@to));

        # underscore sub upcase, eg HELLO_WORLD to WELL_DOWN 
        @rstr.gsub!(underscore(@from).upcase, underscore(@to).upcase);
        
        # downcase sub, eg helloworld to welldown 
        @rstr.gsub!(@from.downcase, @to.downcase);
        # upcase sub, eg HELLOWORLD to WELLDOWN 
        @rstr.gsub!(@from.upcase , @to.upcase);
        
        @rstr
    end

    def underscore(str)
        str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr('-', '_').
        gsub(/\s/, '_'). 
        gsub(/__+/, '_').downcase
       
    end

    def uncapitalize(str)
        str[0,1].downcase + str[1..-1]
    end

    def to_s
        "replacer from #{@name} to #{@to}"
    end
end
