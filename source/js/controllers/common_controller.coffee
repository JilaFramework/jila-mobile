class Controller
  constructor: ($scope, $rootScope, $location, audioService, entryService, i18nService, COMMON_CATEGORY_ID) ->
    $rootScope.$emit 'navigationConfig', 
      labelForTitle: i18nService.get 'commonTitle'
      backAction: () ->
        $location.path('/home')
        return

    $scope.entries = []

    $scope.listen = (entry) ->
      audioService.play(entry.audio) if entry.audio
      return

    entryService.entries_for(COMMON_CATEGORY_ID).then (entries) =>
      $scope.entries = entries


angular.module('app').controller 'commonController', ['$scope', '$rootScope', '$location', 'audioService', 'entryService', 'i18nService', 'COMMON_CATEGORY_ID', Controller]