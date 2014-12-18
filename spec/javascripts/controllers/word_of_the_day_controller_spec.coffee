describe 'WordOfTheDayController', () ->
  controller = null

  $scope = {}
  $rootScope = null
  $q = null
  deferred = null

  allEntries = ['a','b','c','d','e','f','g','h','i']

  entryService = 
    all: () -> 
      deferred = $q.defer()
      deferred.promise

  beforeEach module('app')

  beforeEach inject ($controller, _$q_, _$rootScope_, _$httpBackend_) ->
    $rootScope = _$rootScope_
    $q = _$q_
    _$httpBackend_.whenGET('partials/splash.html').respond(200);
    spyOn(entryService, 'all').and.callThrough()
    controller = $controller 'wordOfTheDayController', 
      $scope: $scope
      entryService: entryService
    return

  describe 'initially', () ->
    it 'it retrieve all of the entries', () ->
      expect(entryService.all).toHaveBeenCalled()

    describe 'when they are returned', () ->
      it 'it should randomly pick one of the entries to show',() ->
        deferred.resolve allEntries
        $rootScope.$apply()

        expect(_.contains(allEntries, $scope.entry)).toBe true