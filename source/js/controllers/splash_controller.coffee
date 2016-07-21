class Controller
  constructor: ($scope, $rootScope, $location, $timeout, SPLASH_SCREEN_DELAY, syncService, configurationService, i18nService) ->
    $rootScope.$emit 'navigationConfig',
      navigationAvailable: false
      searchAvailable: false

    syncFinished = false
    delayFinished = false

    $scope.splashTitle = i18nService.get 'splashTitle'
    $scope.splashSubTitle = i18nService.get 'splashSubTitle'

    $scope.retryAvailable = false
    $scope.retryButtonMessage = i18nService.get 'syncRetryButtonMessage'
    $scope.retrySync = () ->
      syncRemoteContent()

    transitionIfFinished = () ->
      $location.path('/home') if syncFinished and delayFinished

    syncSuccess = () ->
      syncFinished = true
      transitionIfFinished()
      return

    syncFailed = () ->
      if configurationService.initialSyncComplete()
        alert i18nService.get('syncFailureOfflineMessage')
        syncFinished = true
        transitionIfFinished()
      else
        alert i18nService.get('syncFailureRetryMessage')
        $scope.retryAvailable = true

      return

    syncRemoteContent = () ->
      syncService.refresh().then(syncSuccess, syncFailed)

    Platform.isReady () ->
      $timeout () ->
        delayFinished = true
        transitionIfFinished()
      , SPLASH_SCREEN_DELAY

      if window.navigator.onLine
        syncRemoteContent()
      else
        syncFailed()

    $('body').addClass 'body-splash'

angular.module('app').controller 'splashController', ['$scope', '$rootScope', '$location', '$timeout', 'SPLASH_SCREEN_DELAY', 'syncService', 'configurationService', 'i18nService', Controller]
