class Controller
  constructor: ($scope, $rootScope, $location, imageCreditService, i18nService) ->
    $rootScope.$emit 'navigationConfig', 
      labelForTitle: i18nService.get 'aboutTitle'
      backAction: () ->
        $location.path('/home')
        return

    $scope.historyTab = 
      label: i18nService.get 'aboutHistoryTab'
    $scope.resourcesTab = 
      label: i18nService.get 'aboutResourcesTab'
    $scope.locationTab = 
      label: i18nService.get 'aboutLocationTab'
    $scope.partnersTab = 
      label: i18nService.get 'aboutPartnersTab'
    $scope.creditsTab = 
      label: i18nService.get 'aboutCreditsTab'

    $scope.tabs = [
      $scope.historyTab,
      $scope.resourcesTab,
      $scope.locationTab,
      $scope.partnersTab,
      $scope.creditsTab
    ]

    $scope.imageCredits = []
    imageCreditService.all().then (credits) ->
      $scope.imageCredits = credits

    $scope.openLink = (link) ->
      window.open(link, '_system')

    $scope.indexChanged = (index) ->
      $scope.selectedTab = $scope.tabs[index]
    $scope.selectContent = (index) ->
      $scope.indexChanged index
      $scope.content.slickGoTo index
      return
      
    $scope.selectedTab = $scope.historyTab

angular.module('app').controller 'aboutController', ['$scope', '$rootScope', '$location', 'imageCreditService', 'i18nService', Controller]