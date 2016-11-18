class Controller
  constructor: ($scope, $routeParams, $rootScope, $location, $q, $timeout, entryService, i18nService) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: $routeParams.letterId
      backAction: () ->
        $location.path('/dictionary')
        return

    $scope.entries = []
    entryService.entriesIndex = []
    entryService.entryBackButtonURL = '/dictionary/' + $routeParams.letterId
    $scope.isWebView = window.isWebView

    addEntries = (entries) ->
      [].push.apply($scope.entries, entries)
      $timeout(angular.noop, 0)

    computeAndRenderBatch = (entries) ->
      computeAndLetUIRender = $q.when()
      batchSize = 30
      batches = _.chunk(entries, batchSize)
      for batch in batches
        computeNextBatch = angular.bind(null, addEntries, batch)
        computeAndLetUIRender = computeAndLetUIRender.then(computeNextBatch)
      computeAndLetUIRender

    entryService.entries_for_letter($routeParams.letterId).then (entries) =>
      _.sortBy(entries, 'entry_word')
    .then (entries) ->
      computeAndRenderBatch(entries)
      entryService.entriesIndex = entries.map (e) -> e.id

angular.module('app').controller 'letterController', ['$scope', '$routeParams', '$rootScope', '$location', '$q', '$timeout', 'entryService', 'i18nService', Controller]
