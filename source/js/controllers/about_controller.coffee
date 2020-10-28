class Controller
  constructor: ($scope, $rootScope, $location, imageCreditService, i18nService) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: i18nService.get 'aboutTitle'
      backAction: () ->
        $location.path('/home')
        return

    $scope.appTab =
      label: i18nService.get 'aboutAppTab'
    $scope.gooniyandiTab =
      label: i18nService.get 'aboutGooniyandiTab'
    $scope.contactUsTab =
      label: i18nService.get 'aboutContactUsTab'
    $scope.partnersTab =
      label: i18nService.get 'aboutPartnersTab'
    $scope.creditsTab =
      label: i18nService.get 'aboutCreditsTab'

    $scope.tabs = [
      $scope.appTab,
      $scope.gooniyandiTab,
      $scope.contactUsTab,
      $scope.partnersTab,
      $scope.creditsTab
    ]

    $scope.imageCredits = []
    imageCreditService.all().then (credits) ->
      $scope.imageCredits = credits

    $scope.openLink = (link) ->
      cordova.InAppBrowser.open(link, '_blank')

    $scope.indexChanged = (index) ->
      $scope.selectedTab = $scope.tabs[index]
    $scope.selectContent = (index) ->
      $scope.indexChanged index
      $scope.content.slickGoTo index
      return

    $scope.selectedTab = $scope.appTab

angular.module('app').controller 'aboutController', ['$scope', '$rootScope', '$location', 'imageCreditService', 'i18nService', Controller]