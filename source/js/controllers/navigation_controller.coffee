class Controller
  constructor: ($scope, $rootScope, $timeout, $location, entryService, i18nService) ->
    $scope.labelForSearch = i18nService.get 'placeholderSearch'
    $scope.backAction = null
    $scope.searchAvailable = false
    $scope.searchIsVisible = false
    $scope.navigationAvailable = false
    $scope.searchString = ''
    $scope.entries = []
    entryService.entriesIndex = []
    @searchEntriesIndex = []

    $rootScope.$on '$locationChangeStart', () ->
      $scope.showDownloadManager = if $location.path() == '/home' then true else false
      $scope.searchIsVisible = false
      $scope.searchAvailable = true
      return

    $rootScope.$on 'navigationConfig', (e, config) ->
      $timeout () ->
        $scope.labelForTitle = config.labelForTitle if config.labelForTitle != undefined
        $scope.backAction = config.backAction if config.backAction != undefined
        $scope.searchAvailable = config.searchAvailable if config.searchAvailable != undefined
        if config.navigationAvailable != undefined
          $scope.navigationAvailable = config.navigationAvailable
        else
          $scope.navigationAvailable = true
      return

    document.addEventListener 'backbutton', (e) ->
      $scope.$apply () ->
        $scope.backClicked()
        return
      return

    window.backInProgress = 0

    $scope.backClicked = () =>
      $scope.hideSearch()
      if $scope.backAction
        window.backInProgress++
        $('body').addClass 'back'
        $scope.backAction()
      else
        navigator.app.exitApp() if $location.path() == '/home'
      return

    $scope.toggleSearch = () =>
      $scope.searchIsVisible = !$scope.searchIsVisible
      entryService.entriesIndex = @searchEntriesIndex if $scope.searchIsVisible

    $scope.hideSearch = (path) =>
      $scope.searchIsVisible = false
      $location.path(path)

    searchAction = null

    searchFor = (query) =>
      entryService.search_for($scope.searchString).then (entries) =>
        $scope.entries = entries
        entryService.entriesIndex = entries.map (e) -> e.id
        @searchEntriesIndex = entryService.entriesIndex

    $scope.searchStringChanged = () =>
      $timeout.cancel searchAction if searchAction
      if $scope.searchString
        searchString = $scope.searchString
        searchAction = $timeout () ->
          searchFor(searchString)
        , 300
      else
        $scope.entries = []
        entryService.entriesIndex = []

angular.module('app').controller 'navigationController', ['$scope', '$rootScope', '$timeout', '$location', 'entryService', 'i18nService', Controller]