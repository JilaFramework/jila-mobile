describe 'GameService', () ->
  service = null
  $rootScope = null
  $q = null
  
  categoryDeferred = null

  $location = 
    path: () ->,
    search: () ->
  categoryService = 
    get: (categoryId) -> 
      categoryDeferred = $q.defer()
      categoryDeferred.promise
  NUM_GAMES = 8
  GAMES_PER_ROUND = 15
  LIVES_PER_ROUND = 5
  
  beforeEach module 'app'

  beforeEach module ($provide) ->
    $provide.value('$location', $location)
    $provide.value('categoryService', categoryService)
    $provide.constant('GAMES_PER_ROUND', GAMES_PER_ROUND)
    $provide.constant('LIVES_PER_ROUND', LIVES_PER_ROUND)
    return

  beforeEach inject (_$q_, _$rootScope_, _gameService_) ->
    $q = _$q_
    $rootScope = _$rootScope_
    service = _gameService_
    return

  describe 'initially', () ->
    it 'should default the status', () ->
      initialStatus = service.gameStatus()

      expect(initialStatus.livesRemaining).toBe 0
      expect(initialStatus.gameInProgress).toBe false

  describe 'game setup', () ->
    describe 'the games list', () ->
      gamesList = null
    
      beforeEach () -> 
        service.generateGamesListFor(1).then (games) ->
          gamesList = games

      describe 'when the category is available for picture games', () ->
        beforeEach () ->
          category = 
            games: 
              image: true
          categoryDeferred.resolve category
          $rootScope.$apply()

        it 'should include all the word and picture games', () ->
          expect(_.all([3,4,6,7,9], (g) -> _.contains(gamesList, g))).toBe true

      describe 'when the category is available for audio games', () ->
        beforeEach () ->
          category = 
            games: 
              audio: true
          categoryDeferred.resolve category
          $rootScope.$apply()

        it 'should include all the word and audio games', () ->
          expect(_.all([1,2,5,6,7,8], (g) -> _.contains(gamesList, g))).toBe true

      describe 'in general', () ->
        beforeEach () ->
          category = 
            games: {}
          categoryDeferred.resolve category
          $rootScope.$apply()

        it 'should create the configured number of games', () ->
          expect(gamesList.length).toBe GAMES_PER_ROUND

    describe 'initialising the status', () ->

      beforeEach () ->
        service.initialiseStatus()

      it 'should reset the lives', () ->
        expect(service.livesLost).toBe 0
        expect(service.livesRemaining).toBe LIVES_PER_ROUND

      it 'should flag the game as in progress', () ->
        expect(service.gameInProgress).toBe true

    describe 'when setting up games for a category', () ->
      gamesList = [1,2,3]
      deferred = null
      
      beforeEach () ->
        deferred = $q.defer()
        spyOn(service, 'generateGamesListFor').and.returnValue deferred.promise
        spyOn(service, 'initialiseStatus')
        spyOn($location, 'path').and.returnValue $location
        spyOn($location, 'search')

      beforeEach () ->
        service.setupGamesFor(7)
        deferred.resolve gamesList
        $rootScope.$apply()

      it 'should navigate to the first game and pass the remaining in the search string', () ->
        expect($location.path).toHaveBeenCalledWith '/games/7/3'
        expect($location.search).toHaveBeenCalledWith 'games=[1,2]'

      it 'should initialise the game status', () ->
        expect(service.initialiseStatus).toHaveBeenCalled()