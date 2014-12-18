require 'jasmine'
load 'jasmine/tasks/jasmine.rake'

desc "Build the site using Middleman"
task :build_site do
  puts "Building the site using Middleman"
  sh "middleman build"
end

namespace :android do
  desc "Build the app on iOS"
  task :build => [:build_site] do
    puts "Running the app on iOS"
    sh "cordova run ios"
  end

  task :release => [:build_site] do
    puts "Building the app on Android for release"
  end
end

namespace :ios do
  desc "Run the app on iOS"
  task :ios => [:build_site] do
    puts "Running the app on iOS"
    sh "cordova run ios"
  end
end