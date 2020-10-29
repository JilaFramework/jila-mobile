## What is this?

[**Jila**](http://jilaframework.github.io) is a framework for building simple language learning apps. This particular repository is the mobile web / Apache Cordova front end. It was originally intended as a mobile application but has been used on different platforms due to it being based on web technologies.

The **Jila** app is built using the [Middleman](http://middlemanapp.com) static site generator. Client-side assets are managed using [Bower](http://bower.io/). When used as a Cordova app it makes use of the [Apache Cordova](http://cordova.apache.org/) command-line tools which themselves are built on [NodeJS](http://nodejs.org/).

## Prerequisites

- Ruby
- Node.js
- Xcode (for iOS apps)
- Android SDK (for Android apps)

## Installation
1. Run `bundle install` to install the required Ruby gems.

2. Run `yarn` to install Cordova dependencies. If you see the following error: `Current working directory is not a Cordova-based project.`, run `bundle exec rake build_site` to generate a `www` folder which will be consumed by Cordova.

3. Run `yarn setup` to install Bower dependencies.

4. Run `bundle exec rake build_site` to update the `www` folder with Bower dependencies installed.

5. Run `yarn prepare` to install Cordova plugins.

## Getting Started

### Development
To view the app in the browser, run `bundle exec middleman` to start a server at 'http://localhost:4567'.

#### Running app in iOS simulator (Xcode required)
1. If you've made any changes to the static site, run `bundle exec rake build_site` to update the `www` folder.

2. run `yarn run:ios`.

#### Running app in Android simulator (Android studio, JDK 8, and Gradle 6 required)
<sup>For more information, see: https://cordova.apache.org/docs/en/latest/guide/platforms/android/index.html#requirements-and-support</sup>
1. If you've made any changes to the static site, run `bundle exec rake build_site` to update the `www` folder.

2. Set `JAVA_HOME` environment variable to the location of your JDK installation

3. Export the following variables.
```
export ANDROID_SDK=$HOME/Library/Android/sdk
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH
export PATH="$ANDROID_SDK/platform-tools:$PATH"
```

3. Run `yarn run:android`.

### Release

#### Releasing an iOS app
For detailed instructions, see: https://cordova.apache.org/docs/en/latest/guide/platforms/ios/index.html#project-configuration

#### Releasing a signed Android apk
1. Run `keytool -genkey -v -keystore [keystore-name].keystore -alias [key-alias] -keyalg RSA -keysize 2048 -validity 10000` to generate a keystore.

2. Create a `build.json` file in the root directory with the following:
```
{
  "android": {
      "release": {
          "keystore": "path/to/keystore",
          "storePassword": "[store-password]",
          "alias": "[key-alias]",
          "password" : "[key-password]",
          "keystoreType": ""
      }
  }
}
```

3. Run `yarn release:android`.


### Testing
The **Jila** framework uses [Jasmine](http://jasmine.github.io/) for unit testing. Once your server is running it can be accessed at 'http://localhost:4567/jasmine'.

## Customisation
There are a few ways that Jila is configurable out of the box, these are located in the file **configuration.coffee**. The most important of which is probably the **BACKEND_URL** which specifies where the administration console is hosted.
The app can be re-styled without any changes to the functionality. If you do make changes, **please consider submitting a pull request so the community can benefit**.