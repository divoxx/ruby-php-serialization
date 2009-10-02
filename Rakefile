require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "php-serialization"
    gem.summary     = %Q{PHP's serialization implementation for ruby}
    gem.description = %Q{Pure Ruby implementation of php's methods: serialize() and unserializer()}
    gem.email       = "divoxx@gmail.com"
    gem.homepage    = "http://github.com/divoxx/ruby-php-serialization"
    gem.authors     = ["Rodrigo Kochenburger"]
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "cucumber"
    gem.add_dependency "racc"

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts  = ["--options spec/spec.opts"]
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Ruby's PhpSerialization #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


file 'lib/php_serialization/unserializer.rb' => 'lib/php_serialization/unserializer.y' do |t|
  `racc -o #{t.name} #{t.prerequisites[0]}`
end

desc "Compile all the necessary files, such as .y grammar files"
task :compile => ['lib/php_serialization/unserializer.rb']