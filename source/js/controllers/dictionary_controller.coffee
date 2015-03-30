class Controller
  constructor: ($scope, $rootScope, $location, entryService, i18nService) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: i18nService.get 'dictionaryTitle'
      backAction: () ->
        $location.path('/home')

    entryService.all().then (entries) =>
      first_letters = _.map(entries, (entry) -> entry.entry_word[0])
      $scope.letters = _.uniq(first_letters).sort()

angular.module('app').controller 'dictionaryController', ['$scope', '$rootScope', '$location', 'entryService', 'i18nService', Controller]
