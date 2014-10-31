class Controller
  constructor: ($scope, $rootScope, $location, categoryService, i18nService) ->
    $rootScope.$emit 'navigationConfig', 
      labelForTitle: i18nService.get 'categoriesTitle'
      backAction: () ->
        $location.path('/home')
        return

    $scope.categories = []
    categoryService.all().then (categories) =>
      $scope.categories = categories

angular.module('app').controller 'categoriesController', ['$scope', '$rootScope', '$location', 'categoryService', 'i18nService', Controller]