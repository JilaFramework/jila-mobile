class Controller
  constructor: ($scope, $rootScope, $location, categoryService, gameService, i18nService) ->
    $rootScope.$emit 'navigationConfig', 
      labelForTitle: i18nService.get 'gamesTitle'
      backAction: () ->
        $location.path('/home')
        return

    $scope.categories = []
    categoryService.all().then (categories) =>
      $scope.categories = categories

    $scope.startGamesFor = (category) ->
      gameService.setupGamesFor(category.id)

angular.module('app').controller 'gamesController', ['$scope', '$rootScope', '$location', 'categoryService', 'gameService', 'i18nService', Controller]