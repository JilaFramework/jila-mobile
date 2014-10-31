class Controller
  constructor: ($scope, $rootScope, $routeParams, $location, $timeout, i18nService) ->
    $rootScope.$emit 'navigationConfig', 
      searchAvailable: false
      navigationAvailable: false

    roundStatus = JSON.parse($location.search()['status'])
    $scope.labelForTitle = roundStatus.resultTitle
    $scope.labelForMessage = roundStatus.explanation
    $scope.answerImage = roundStatus.correctImage

    $scope.labelForClose = i18nService.get 'acknowledgeButton'
    
    gameStatus = roundStatus.gameStatus
    $scope.success = gameStatus.lastRoundSuccessful

    livesLost = 
      if gameStatus.livesLost
        [0..gameStatus.livesLost-1].map () -> 
          lost: true
      else
        []
    livesRemaining = 
      if gameStatus.livesRemaining 
        [0..gameStatus.livesRemaining-1].map () -> 
          lost: false
      else 
        []
    $scope.lives = livesLost.concat livesRemaining

    unless gameStatus.lastRoundSuccessful
      lastLifeLost = _.last(livesLost)
      lastLifeLost.lost = false

      $timeout () ->
        lastLifeLost.lost = true
      , 1500

    $scope.close = () -> 
      if gameStatus.gameInProgress
        remainingGames = JSON.parse $location.search()['games']

        if remainingGames.length > 0
          nextGame = remainingGames.pop()
          $location.path("/games/#{$routeParams.categoryId}/#{nextGame}").search("games=#{JSON.stringify(remainingGames)}")
        else
          $location.path('/games/success').search('')
      else
        $location.path('/games/failure').search('')

    $scope.loaded = false
    $timeout () ->
      $scope.loaded = true
    , 500

angular.module('app').controller 'resultController', ['$scope', '$rootScope', '$routeParams', '$location', '$timeout', 'i18nService', Controller]