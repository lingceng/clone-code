require 'ostruct'
require_relative 'lib/app'

opts = OpenStruct.new

opts.from = 'HelloWorld'
opts.to = 'WellDone'
path = 'doc/*.java' 


app = App.new(opts)
app.clone(path)
