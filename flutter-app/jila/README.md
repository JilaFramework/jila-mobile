## Jila mobile
![[jila-mobile-screenshot.png]]

#### What is this?

In line with current industry standards for performance and security, I have attempted to re-write the Jila framework mobile application using Google's popular cross-platform framework, <a href='https://flutter.dev/'>Flutter</a>.

#### But we already have a mobile app, why this? why Flutter?

Flutter is as close to native performance and security as you can get to native Swift UI and Kotlin/Java Android applications respectfully, while retaining all of the benefits of 'write once, use everywhere', i.e. Flutter can target Android and IOS out of the box, with no additional code, and no need to be an expert in both native IOS and Android development. 

#### Cool, so how do I get started?
If you wish to debug and run locally against IOS you will need a computer running OSX, i.e. a Macbook. To target Android or Web, you can run locally on a Windows machine.

###### Start the backend

Before you run the mobile application, you will want to start the back end .NET 5 API and ensure Strapi is configured and running. Refer to the <a href='https://github.com/JilaFramework/jila-backend'>jila-backend<a/> repo on GitHub for info on how to get started.

###### Changing the target back end URL in the app
The application stack consists of this Flutter application, calling a .NET 5 REST API, which talks to a Strapi CMS back end. In order to target the .NET 5 API, you first need to change the base URL in the application, this can be found in the `lib/backend/api_calls.dart` file. Simple change the placeholder URL to the relevant URL of your application. If running locally, this won't change if you ran the back end by using `dotnet run` as this will run the API on `http://localhost:5000`.

Refer to <a href='https://flutter.dev/docs/get-started/install'>this guide</a> to get up and running with Flutter on your relevant target machine.

###### Installing Flutter

###### IOS

Navigate to the "ios" sub-directory in the terminal and ensure you have the relevant Cocopods installed by running `gem install cocoapods --user-install`
see this <a href='https://guides.cocoapods.org/using/getting-started.html'>site<a/> for more information.

Additionally, these <a href='https://flutter.dev/docs/get-started/flutter-for/ios-devs'>Flutter IOS docs<a/> explain IOS Flutter development in more detail.
	
###### Android
	
Ensure you have Java 8 or 11 OpenJDK installed and available in your path. 
Next, open an Android emulator from the AVD manager and run `flutter run` to open application on the device. Running Flutter run should run all the required gradle build steps to compile and launch the application.
	
#### Future state/project goals
	
Ideally to stay in touch with the theme of low-code/no-code aspects of this solution, we could integrate this app with <a href='https://flutterflow.io/'>FlutterFlow<a/> so that the entire lifecycle is handled for the app, and it can be fully managed from app assets, colour palettes, themes, icons etc all the way from the start to the relevant app stores.
	
#### TODOs
	
As I wrote this entire stack by myself in two days, there is a bit of work to do before this could be considered production ready.
	
- General tidy up of code, more focus on DRY principals
- Move api_calls.dart model code into relevant model files rather than lumping it all in one file
- Better conditional logic and error handling, the app is quite flaky at the moment due to this
- Investigate where API calls in app may be duplicated, resulting in performance issues down the road