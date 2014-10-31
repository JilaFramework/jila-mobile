class Controller
  constructor: ($scope, $rootScope, i18nService) ->
    $rootScope.$emit 'navigationConfig', 
      labelForTitle: i18nService.get 'homeTitle'
      backAction: null

    $scope.labelForDictionary = i18nService.get 'homeDictionary'
    $scope.labelForCategories = i18nService.get 'homeCategories'
    $scope.labelForLearn = i18nService.get 'homeLearn'
    $scope.labelForCommon = i18nService.get 'homeCommon'
    $scope.labelForWordOfTheDay = i18nService.get 'homeWordOfTheDay'
    $scope.labelForAbout = i18nService.get 'homeAbout'

    WARNING_KEY = 'warningSeen'
    warningSeen = () -> 
      window.localStorage[WARNING_KEY] = true
      return

    showWarningMessage = () ->
      warningTitle = i18nService.get 'homeWarningTitle'
      warningButton = i18nService.get 'acknowledgeButton'
      warningMessage = i18nService.get 'homeWarningMessage'

      if navigator.notification
        navigator.notification.alert warningMessage, warningSeen, warningTitle, warningButton
      else
        alert warningMessage
        warningSeen()

    showWarningMessage() unless window.localStorage[WARNING_KEY]

angular.module('app').controller 'homeController', ['$scope', '$rootScope', 'i18nService', Controller]