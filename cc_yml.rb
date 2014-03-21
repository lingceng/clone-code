require 'ostruct'
require 'yaml'
require_relative 'lib/app'

conf = YAML.load_file('task.yml')

opts = OpenStruct.new(conf)

app = App.new(opts)
for item in opts.path
  app.clone(item)
end
