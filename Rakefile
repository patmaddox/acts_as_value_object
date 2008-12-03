require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "acts_as_value_object"
    s.summary = "TODO"
    s.email = "pat.maddox@gmail.com"
    s.homepage = "http://github.com/pat-maddox/acts_as_value_object"
    s.description = "TODO"
    s.authors = ["Pat Maddox"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

begin
  require 'spec/rake/spectask'

  desc "Run the spec suite"
  Spec::Rake::SpecTask.new do |t|
    t.spec_opts = ['--options', "spec/spec.opts"]
    t.spec_files = FileList['spec/**/*_spec.rb']
  end

rescue LoadError
  at_exit do
    puts <<-EOS

****************************************************
To use rspec for testing you must install rspec gem:
    gem install rspec
EOS
  end
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'acts_as_value_object'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

task :default => :rcov
