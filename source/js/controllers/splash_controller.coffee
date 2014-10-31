class Controller
  constructor: ($scope, $rootScope, $location, $timeout, SPLASH_SCREEN_DELAY, syncService) ->
    syncFinished = false
    delayFinished = false

    $rootScope.$emit 'navigationConfig', 
      navigationAvailable: false
      searchAvailable: false

    transitionIfFinished = () ->
      $location.path('/home') if syncFinished and delayFinished

    Platform.isReady () ->
      $timeout () ->
        delayFinished = true
        transitionIfFinished()
      , SPLASH_SCREEN_DELAY

      syncService.refresh().then () ->
        syncFinished = true
        transitionIfFinished()
        return
      , () ->
        # TODO: This should display an error somehow
        console.log('Error syncing')
        syncFinished = true
        transitionIfFinished()
        return

angular.module('app').controller 'splashController', ['$scope', '$rootScope', '$location', '$timeout', 'SPLASH_SCREEN_DELAY', 'syncService', Controller]