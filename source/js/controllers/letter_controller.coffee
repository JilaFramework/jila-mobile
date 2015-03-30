class Controller
  constructor: ($scope, $routeParams, $rootScope, $location, entryService, i18nService) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: $routeParams.letterId
      backAction: () ->
        $location.path('/dictionary')
        return

    $scope.category = {}
    $scope.entries = []

    entryService.entries_for_letter($routeParams.letterId).then (entries) =>
      sorted_entries = _.sortBy(entries, 'entry_word')
      # grouped_entries = _.groupBy(sorted_entries, (e) -> e.entry_word[0])
      $scope.entries = sorted_entries 
        # grouped_entries[$routeParams.letterId]

angular.module('app').controller 'letterController', ['$scope', '$routeParams', '$rootScope', '$location', 'entryService', 'i18nService', Controller]
