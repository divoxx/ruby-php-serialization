require "bundler/gem_tasks"

task default: [:compile]

desc "Compile all the necessary files, such as .y grammar files"
task compile: ['lib/php_serialization/unserializer.rb']

file 'lib/php_serialization/unserializer.rb' => 'lib/php_serialization/unserializer.y' do |t|
  `./bin/racc -o #{t.name} #{t.prerequisites[0]}`
end
