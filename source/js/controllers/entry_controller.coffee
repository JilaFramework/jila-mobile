class Controller
  constructor: ($scope, $routeParams, entryService, audioService, $rootScope) ->
    $rootScope.$emit 'navigationConfig', 
      labelForTitle: ""
      backAction: () ->
        window.history.back()
        return

    $scope.entry = {}

    entryService.get($routeParams.entryId).then (entry) =>
      $scope.entry = entry
      $rootScope.$emit 'navigationConfig', 
        labelForTitle: entry.entry_word

    $scope.listen = () =>
      audioService.play($scope.entry.audio) if $scope.entry
      return

angular.module('app').controller 'entryController', ['$scope', '$routeParams', 'entryService', 'audioService', '$rootScope', Controller]