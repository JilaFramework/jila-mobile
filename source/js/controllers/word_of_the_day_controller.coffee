class Controller
  constructor: ($scope, $rootScope, $location, entryService, audioService, i18nService) ->
    $rootScope.$emit 'navigationConfig', 
      labelForTitle: i18nService.get 'wordOfTheDayTitle'
      backAction: () ->
        $location.path('/home')
        return

    $scope.entry = {}

    $scope.listen = () ->
      audioService.play($scope.entry.audio) if $scope.entry.audio
      return

    entryService.all().then (entries) ->
      today = moment('0', 'hh').unix()
      index = Math.floor(Math.randomWithSeed(today) * entries.length) - 1
      $scope.entry = entries[index]


angular.module('app').controller 'wordOfTheDayController', ['$scope', '$rootScope', '$location', 'entryService', 'audioService', 'i18nService', Controller]