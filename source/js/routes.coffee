app = angular.module 'app'

app.config ['$routeProvider'
  ($routeProvider) ->
    $routeProvider.when '/', templateUrl: 'partials/splash.html', controller: 'splashController'
    $routeProvider.when '/home', templateUrl: 'partials/home.html', controller: 'homeController'
    $routeProvider.when '/dictionary', templateUrl: 'partials/dictionary.html', controller: 'dictionaryController'
    $routeProvider.when '/categories', templateUrl: 'partials/categories.html', controller: 'categoriesController'
    $routeProvider.when '/categories/:categoryId', templateUrl: 'partials/category.html', controller: 'categoryController'
    $routeProvider.when '/entries/:entryId', templateUrl: 'partials/entry.html', controller: 'entryController'

    $routeProvider.when '/common', templateUrl: 'partials/common.html', controller: 'commonController'

    $routeProvider.when '/word_of_the_day', templateUrl: 'partials/entry.html', controller: 'wordOfTheDayController'

    $routeProvider.when '/about', templateUrl: 'partials/about.html', controller: 'aboutController'

    $routeProvider.when '/games', templateUrl: 'partials/games.html', controller: 'gamesController'
    $routeProvider.when '/games/:categoryId/1', templateUrl: 'partials/games/audio_to_options.html', controller: 'audioToLanguageController'
    $routeProvider.when '/games/:categoryId/2', templateUrl: 'partials/games/audio_to_options.html', controller: 'audioToTranslationController'
    $routeProvider.when '/games/:categoryId/3', templateUrl: 'partials/games/picture_to_options.html', controller: 'pictureToLanguageController'
    $routeProvider.when '/games/:categoryId/4', templateUrl: 'partials/games/text_to_pictures.html', controller: 'picturesToLanguageController'
    $routeProvider.when '/games/:categoryId/5', templateUrl: 'partials/games/audio_to_text.html', controller: 'audioToTranslationTextController'
    $routeProvider.when '/games/:categoryId/6', templateUrl: 'partials/games/text_to_options.html', controller: 'languageToTranslationController'
    $routeProvider.when '/games/:categoryId/7', templateUrl: 'partials/games/text_to_text.html', controller: 'languageToTranslationTextController'
    $routeProvider.when '/games/:categoryId/8', templateUrl: 'partials/games/audio_to_unjumble.html', controller: 'audioToUnjumbleController'
    $routeProvider.when '/games/:categoryId/9', templateUrl: 'partials/games/picture_to_unjumble.html', controller: 'pictureToUnjumbleController'
    
    $routeProvider.when '/games/:categoryId/result', templateUrl: 'partials/games/result.html', controller: 'resultController'
    $routeProvider.when '/games/success', templateUrl: 'partials/games/success.html', controller: 'successController'
    $routeProvider.when '/games/failure', templateUrl: 'partials/games/failure.html', controller: 'failureController'
]