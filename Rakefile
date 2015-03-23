require 'jasmine'
load 'jasmine/tasks/jasmine.rake'

desc "Build the site using Middleman"
task :build_site do
  puts "Building the site using Middleman"
  sh "middleman build"
end

desc "Bootstrap the project using Middleman and Cordova"
task :bootstrap => [:build_site] do
  puts "Adding plugins"
  sh "cordova plugin add org.apache.cordova.device@0.2.11"
  sh "cordova plugin add org.apache.cordova.dialogs@0.2.8"
  sh "cordova plugin add org.apache.cordova.file@1.2.0"
  sh "cordova plugin add org.apache.cordova.inappbrowser@0.5.2"
  sh "cordova plugin add org.apache.cordova.media@0.2.11"
  sh "cordova plugin add org.apache.cordova.statusbar@0.1.10"

  puts "Adding iOS and Android platforms"
  sh "cordova platform add ios"
  sh "cordova platform add android"
end

namespace :android do
  desc "Build the app on Android"
  task :build => [:build_site] do
    puts "Building the app for Android"
    sh "cordova build android"
  end

  desc "Run the app on Android"
  task :run => [:build_site] do
    puts "Running the app on Android"
    sh "cordova run android"
  end

  desc "Build the app on Android for release"
  task :release => [:build_site] do
    puts "Building the app on Android for release"
    sh "cordova build android --release"
  end
end

namespace :ios do
  desc "Run the app on iOS"
  task :build => [:build_site] do
    puts "Building the app for iOS"
    sh "cordova build ios"
  end

  desc "Run the app on iOS"
  task :run => [:build_site] do
    puts "Running the app on iOS"
    sh "cordova run ios"
  end

  desc "Build the app on iOS for release"
  task :release => [:build_site] do
    puts "Building the app on iOS for release"
    sh "cordova build ios --release"
  end
end