require 'rubygems'
require 'spec'
require 'active_record'
this_dir = File.expand_path(File.dirname(__FILE__))
require this_dir + '/../lib/acts_as_value_object.rb'

FileUtils.mkdir(this_dir + '/log') unless File.directory?(this_dir + '/log')
ActiveRecord::Base.logger = Logger.new(this_dir + "/log/test.log")

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "#{this_dir}/db/test.sqlite3")
load(this_dir + '/db/schema.rb')
