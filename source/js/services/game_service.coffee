class Service
  constructor: (@$location, @$q, @categoryService, @GAMES_PER_ROUND, @LIVES_PER_ROUND) ->
    @gameInProgress = false
    @livesRemaining = 0

  success: () =>
    @lastRoundSuccessful = true
    @gameStatus()

  fail: () =>
    @livesRemaining--
    @gameInProgress = false if @livesRemaining == 0
    @lastRoundSuccessful = false
    @gameStatus()   

  initialiseStatus: () =>
    @livesLost = 0
    @livesRemaining = @LIVES_PER_ROUND
    @gameInProgress = true
    @lastRoundSuccessful = true

  gameStatus: () =>
    livesLost: @LIVES_PER_ROUND - @livesRemaining,
    livesRemaining: @livesRemaining,
    gameInProgress: @gameInProgress
    lastRoundSuccessful: @lastRoundSuccessful

  generateGamesListFor: (categoryId) =>
    deferred = @$q.defer()

    @categoryService.get(categoryId).then (category) =>
      wordGames = [6,7]
      audioGames = [1,2,5,8]
      pictureGames = [3,4,9]

      games = wordGames
      games = games.concat audioGames if category.games.audio
      games = games.concat pictureGames if category.games.image

      numGamesRemaining = @GAMES_PER_ROUND - games.length
      randomGames = [1..numGamesRemaining].map (g) -> 
        randomIndex = Math.floor(Math.random() * (games.length - 1))
        games[randomIndex]
      games = games.concat randomGames

      deferred.resolve _.sample(games, @GAMES_PER_ROUND)

    return deferred.promise

  setupGamesFor: (categoryId) =>
    @generateGamesListFor(categoryId).then (games) =>
      @initialiseStatus()
    
      first_game = games.pop()    
      @$location.path("/games/#{categoryId}/#{first_game}").search("games=#{JSON.stringify(games)}")


angular.module('app').service 'gameService', ['$location', '$q', 'categoryService', 'GAMES_PER_ROUND', 'LIVES_PER_ROUND', Service]