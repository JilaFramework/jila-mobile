## What is this?

[**Jila**](http://jilaframework.github.io) is a framework for building simple language learning apps. This particular repository is the mobile web / Apache Cordova front end. It was originally intended as a mobile application but has been used on different platforms due to it being based on web technologies.

The **Jila** app is built using the [Middleman](http://middlemanapp.com) static site generator. Client-side assets are managed using [Bower](http://bower.io/). When used as a Cordova app it makes use of the [Apache Cordova](http://cordova.apache.org/) command-line tools which themselves are built on [NodeJS](http://nodejs.org/).

## Prerequisites

- Ruby
- Node.js
- Xcode (for iOS apps)
- Android SDK (for Android apps)

## Installation

Install Ruby gems
`bundle install`

Bootstrap non-Ruby tools
`yarn`
`yarn setup`

Bootstrap Cordova platforms and plugins
After running `bundle exec rake build_site`, run `yarn prepare`.

## Getting Started

### Development
To view the app in the browser, run `bundle exec middleman` to start a server at 'http://localhost:4567'.

To view the app in an IOS/Android simulator:
1. Run `bundle exec rake build_site` to generate a `www` folder which will be consumed by Cordova.

2. run `yarn run:ios` or `yarn run:android`


### Testing
The **Jila** framework uses [Jasmine](http://jasmine.github.io/) for unit testing. Once your server is running it can be accessed at 'http://localhost:4567/jasmine'.

## Customisation
There are a few ways that Jila is configurable out of the box, these are located in the file **configuration.coffee**. The most important of which is probably the **BACKEND_URL** which specifies where the administration console is hosted.
The app can be re-styled without any changes to the functionality. If you do make changes, **please consider submitting a pull request so the community can benefit**.