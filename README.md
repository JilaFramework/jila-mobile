* Work in Progress. *

# What is this?

**Jila** is a framework for building simple language learning apps. This particular repository is the mobile web / Apache Cordova front end.

# Requirements

The **Jila** app is built using the [Middleman](http://middlemanapp.com) static site generator. Client-side assets are managed using [Bower](http://bower.io/). When used as a Cordova app it makes use of the [Apache Cordova](http://cordova.apache.org/) command-line tools which themselves are built on [NodeJS](http://nodejs.org/).

# Getting Started
## Development
For development, the process is simple. Run a 'bower install' to get the assets, then once you have Middleman installed use 'middleman server' to load your work.
## Testing
The **Jila** framework uses [Jasmine](http://jasmine.github.io/) for unit testing. Once your server is running it can be accessed at 'http://localhost:[port]/jasmine'
## Mobile App
### Enable Platforms
The core repository includes a list of the Cordova plugins currently being used, but not the platforms eg. iOS or Android. To enable these you will need to use the Cordova command-line tools to add what you require. Check with the Cordova documentation on how to do this.
### Build and Run
Middleman is configured to output the compiled code into the directory structure expected by Cordova. As such, to run on the target platform it's just a matter of building via Middleman and running the appropriate Cordova command eg. 'middleman build && cordova run ios'. To simplify this process we have created some Rake tasks, use 'rake -T' to see the available commands.