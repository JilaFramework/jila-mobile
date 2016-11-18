class Controller
  constructor: ($scope, $routeParams, entryService, audioService, downloadService, $rootScope, $location) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: ""
      backAction: () ->
        if window.hasSwiped > 0
          $location.url(entryService.entryBackButtonURL + "#entry-" + $scope.entry.id)
        else
          $location.path(entryService.entryBackButtonURL)
        window.hasSwiped = 0
        return

    $scope.entry = {}
    window.hasSwiped = 0 if ! window.hasSwiped?
    $scope.isWebView = window.isWebView

    entryService.get($routeParams.entryId).then (entry) =>
      $scope.entry = entry
      $scope.formattedDescription = marked(entry.description)
      entryService.entryBackButtonURL = '/home' if ! entryService.entryBackButtonURL?
      $rootScope.$emit 'navigationConfig',
        labelForTitle: entry.entry_word
      downloadService.saveAssetsForEntry(entry)

    $scope.listen = () =>
      audioService.play($scope.entry.audio) if $scope.entry
      return

    $scope.call_listen = () =>
      audioService.play($scope.entry.call_audio) if $scope.entry
      return

    $scope.sentence_listen = () =>
      audioService.play($scope.entry.sentence_audio) if $scope.entry
      return

    getPreviousEntryID = (arr, curr) ->
      foundItem = arr.filter (e) -> e == curr
      i = arr.indexOf( parseInt(foundItem) );
      if i < 1 then i = arr.length
      return arr[i-1]
    getNextEntryID = (arr, curr) ->
      foundItem = arr.filter (e) -> e == curr
      i = arr.indexOf( parseInt(foundItem) );
      if i >= arr.length-1 then i = -1
      return arr[i+1]

    $scope.swipeChangeEntry = (dir) ->
      window.hasSwiped++
      if dir == 'previous'
        $('body').addClass("swipe-back")
        previousID = getPreviousEntryID(entryService.entriesIndex, $scope.entry.id)
        $location.path('entries/' + previousID);
      else
        $('body').removeClass("swipe-back")
        nextID = getNextEntryID(entryService.entriesIndex, $scope.entry.id)
        $location.path('entries/' + nextID)
      return false

angular.module('app').controller 'entryController', ['$scope', '$routeParams', 'entryService', 'audioService', 'downloadService', '$rootScope', '$location', Controller]