class Controller
  constructor: ($scope, $rootScope, $location, imageCreditService, i18nService) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: i18nService.get 'aboutTitle'
      backAction: () ->
        $location.path('/home')
        return

    $scope.appVersion = "getting version"
    Platform.isReady () ->

      if typeof cordova != 'undefined'
        cordova.getAppVersion.getVersionNumber().then (version) ->
          $scope.$apply () ->
            $scope.appVersion = version
      else
        $scope.appVersion = ""

    $scope.imageCredits = []
    imageCreditService.all().then (credits) ->
      $scope.imageCredits = credits

    $scope.openLink = (link) ->
      window.open(link, '_system')

angular.module('app').controller 'aboutController', ['$scope', '$rootScope', '$location', 'imageCreditService', 'i18nService', Controller]