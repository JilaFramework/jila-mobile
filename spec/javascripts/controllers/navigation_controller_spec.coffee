describe 'NavigationController', () ->
  controller = null

  $scope = {}
  $rootScope = null
  $q = null
  deferred = null

  entryService = 
    search_for: () ->
      deferred = $q.defer()
      deferred.promise

  beforeEach module('app')

  beforeEach inject ($controller, _$q_, _$rootScope_) ->
    $rootScope = _$rootScope_
    $q = _$q_
    spyOn(entryService, 'search_for').and.callThrough()
    controller = $controller 'navigationController', 
      $scope: $scope
      entryService: entryService
    return

  it 'search should not be visible by default', () ->
    expect($scope.searchIsVisible).toBe false

  it 'should toggle visibility of the search', () ->
    $scope.toggleSearch()
    expect($scope.searchIsVisible).toBe true
    $scope.toggleSearch()
    expect($scope.searchIsVisible).toBe false

  it 'should retrieve entries matching the search string', () ->
    $scope.searchString = 'angry'
    $scope.searchStringChanged()

    entries = ['bili']
    deferred.resolve entries
    $rootScope.$apply()

    expect($scope.entries).toEqual entries
    expect(entryService.search_for).toHaveBeenCalled()

  it 'should not search if the search string is empty', () ->
    $scope.searchStringChanged()

    expect(entryService.search_for).not.toHaveBeenCalled()