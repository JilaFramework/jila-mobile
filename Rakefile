require 'jasmine'
load 'jasmine/tasks/jasmine.rake'

desc "Install tools (this may require sudo)"
task :install_tools do
  sh "npm install -g bower"
  sh "npm install -g cordova plugman ios-deploy ios-sim"
  puts "Installing Bower dependencies"
  sh "bower install"
end

desc "Bootstrap the project using Middleman and Cordova"
task :bootstrap do

  puts "Building the site using Middleman"
  sh "bundle exec middleman build"

  puts "Installing Cordova and plugins"
  sh "cordova plugin add cordova-plugin-device@1.1.2"
  sh "cordova plugin add cordova-plugin-dialogs@1.2.1"
  sh "cordova plugin add cordova-plugin-file@4.2.0"
  sh "cordova plugin add cordova-plugin-inappbrowser@1.4.0"
  sh "cordova plugin add cordova-plugin-media@2.3.0"
  sh "cordova plugin add cordova-plugin-statusbar@2.1.3"
  sh "cordova plugin add cordova-plugin-whitelist@1.2.2"
  sh "cordova plugin add cordova-plugin-network-information@1.2.1"
  sh "cordova plugin add cordova-plugin-app-version@0.1.8"

  puts "Adding iOS and Android platforms"
  sh "cordova platform add ios"
  sh "cordova platform add android"
end

desc "Build the site using Middleman"
task :build_site do
  puts "Building the site using Middleman"
  sh "bundle exec middleman build"
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