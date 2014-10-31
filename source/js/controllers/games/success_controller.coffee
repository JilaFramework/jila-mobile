class Controller
  constructor: ($scope, $location, $timeout, i18nService) ->
    $scope.labelForTitle = i18nService.get 'sessionTitleSuccess'
    $scope.labelForMessage = i18nService.get 'sessionMessageSuccess'
    $scope.labelForClose = i18nService.get 'acknowledgeButton'
    $scope.close = () -> $location.path('/games')

    $scope.loaded = false
    $timeout () ->
      $scope.loaded = true
    , 0

angular.module('app').controller 'successController', ['$scope', '$location', '$timeout', 'i18nService', Controller]