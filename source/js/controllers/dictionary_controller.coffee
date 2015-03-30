class Controller
  constructor: ($scope, $rootScope, $location, entryService, i18nService) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: i18nService.get 'dictionaryTitle'
      backAction: () ->
        $location.path('/home')

    entryService.all().then (entries) =>
      sorted_entries = _.sortBy(entries, 'entry_word')
      this.grouped_entries = _.groupBy(sorted_entries, (e) -> e.entry_word[0])
      $scope.letters = _.keys(this.grouped_entries)

angular.module('app').controller 'dictionaryController', ['$scope', '$rootScope', '$location', 'entryService', 'i18nService', Controller]
