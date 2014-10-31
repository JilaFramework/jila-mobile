class Controller
  constructor: ($scope, $location, $timeout, i18nService) ->
    $scope.labelForTitle = i18nService.get 'sessionTitleFailure'
    $scope.labelForMessage = i18nService.get 'sessionMessageFailure'
    $scope.labelForClose = i18nService.get 'acknowledgeButton'
    $scope.close = () -> $location.path('/games')

    $scope.loaded = false
    $timeout () ->
      $scope.loaded = true
    , 0

angular.module('app').controller 'failureController', ['$scope', '$location', '$timeout', 'i18nService', Controller]