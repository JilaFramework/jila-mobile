class Controller
  constructor: ($scope, $routeParams, categoryService, entryService, $rootScope, $location, $q, $timeout) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: ''
      backAction: () ->
        $location.path('/categories')
        return

    $scope.category = {}
    $scope.entries = []
    entryService.entriesIndex = []
    entryService.entryBackButtonURL = '/categories/' + $routeParams.categoryId
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

    categoryService.get($routeParams.categoryId).then (category) ->
      $rootScope.$emit 'navigationConfig',
        labelForTitle: category.name
      $scope.category = category
      entryService.entries_for(category.id)
    .then (entries) ->
      computeAndRenderBatch(entries)
      entryService.entriesIndex = entries.map (e) -> e.id
    .then (_) ->
      console.log 'done'

angular.module('app').controller 'categoryController', ['$scope', '$routeParams', 'categoryService', 'entryService', '$rootScope', '$location', '$q', '$timeout', Controller]