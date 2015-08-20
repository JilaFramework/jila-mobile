## What is this?

[**Jila**](http://jilaframework.github.io) is a framework for building simple language learning apps. This particular repository is the mobile web / Apache Cordova front end. It was originally intended as a mobile application but has been used on different platforms due to it being based on web technologies.

The **Jila** app is built using the [Middleman](http://middlemanapp.com) static site generator. Client-side assets are managed using [Bower](http://bower.io/). When used as a Cordova app it makes use of the [Apache Cordova](http://cordova.apache.org/) command-line tools which themselves are built on [NodeJS](http://nodejs.org/).

## Prerequisites

- Ruby
- Node.js
- Xcode (for iOS apps)
- Android SDK (for Android apps)
- Apache Ant (for Android apps)

## Installation

Install Ruby gems
`bundle install`

Bootstrap non-Ruby tools (this may require sudo)
`bundle exec rake install_tools`

Bootstrap Cordova platforms and plugins
`bundle exec rake bootstrap`

## Getting Started

### Development
Use `bundle exec middleman` to load your work. This will by default start a server at 'http://localhost:4567'.

### Testing
The **Jila** framework uses [Jasmine](http://jasmine.github.io/) for unit testing. Once your server is running it can be accessed at 'http://localhost:4567/jasmine'.

### Mobile Web
As it is based on web technologies, Jila can be used on any platform that supports the modern web. It falls back to HTML5 audio for playback and remote access of images and audio. There is a rake task for building the site which you can use with `bundle exec rake build_site`.

### Mobile App
There are rake tasks that coordinate the building of the site and deploying to the various platforms. You can see the full list of them using `bundle exec rake -T`.

## Customisation
There are a few ways that Jila is configurable out of the box, these are located in the file **configuration.coffee**. The most important of which is probably the **BACKEND_URL** which specifies where the administration console is hosted.
The app can be re-styled without any changes to the functionality. If you do make changes, **please consider submitting a pull request so the community can benefit**.