require 'jasmine'
load 'jasmine/tasks/jasmine.rake'

desc "Build the site using Middleman"
task :build do
  puts "Building the site using Middleman"
  exec "middleman build"
end

namespace :cordova do
  desc "Run the app on iOS"
  task :ios => [:build] do
    puts "Running the app on iOS"
    exec "cordova run ios"
  end
  desc "Run the app on Android"
  task :android => [:build] do
    puts "Running the app on Android"
    exec "cordova run android"
  end
end