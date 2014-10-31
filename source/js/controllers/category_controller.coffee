class Controller
  constructor: ($scope, $routeParams, categoryService, entryService, $rootScope, $location) ->
    $rootScope.$emit 'navigationConfig', 
      labelForTitle: ''
      backAction: () ->
        $location.path('/categories')
        return

    $scope.category = {}
    $scope.entries = []

    categoryService.get($routeParams.categoryId).then (category) =>
      $rootScope.$emit 'navigationConfig', 
        labelForTitle: category.name
      $scope.category = category
      entryService.entries_for(category.id).then (entries) =>
        $scope.entries = entries

angular.module('app').controller 'categoryController', ['$scope', '$routeParams', 'categoryService', 'entryService', '$rootScope', '$location', Controller]