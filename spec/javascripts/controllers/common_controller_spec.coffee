describe 'CommonController', () ->
  controller = null

  $scope = {}
  $rootScope = null
  $q = null
  deferred = null

  COMMON_CATEGORY_ID = 3
  entryService = 
    entries_for: () -> 
      deferred = $q.defer()
      deferred.promise

  audioService = 
    play: () ->

  beforeEach module('app')

  beforeEach inject ($controller, _$q_, _$rootScope_) ->
    $rootScope = _$rootScope_
    $q = _$q_
    spyOn(entryService, 'entries_for').and.callThrough()
    spyOn(audioService, 'play').and.callThrough()
    controller = $controller 'commonController', 
      $scope: $scope
      audioService: audioService
      entryService: entryService
      COMMON_CATEGORY_ID: COMMON_CATEGORY_ID
    return

  describe 'initially', () ->
    it 'it should find the entries for the common category id', () ->
      expect(entryService.entries_for).toHaveBeenCalledWith(COMMON_CATEGORY_ID)

  describe 'listen', () ->
    it 'should call play on the audio service with the selected audio',() ->
      $scope.listen audio: 'audio.m4a'
      expect(audioService.play).toHaveBeenCalledWith('audio.m4a')

    it 'should not do anything if the entry has no audio', () ->
      $scope.listen audio: null
      expect(audioService.play).not.toHaveBeenCalled()