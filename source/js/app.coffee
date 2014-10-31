app = angular.module 'app', [
  'ngRoute', 
  'ngTouch', 
  'ngAnimate', 
  'configuration', 
  'angulartics', 
  'angulartics.google.analytics',
  'pasvaz.bindonce'
]

app.config [
  '$compileProvider', ($compileProvider) ->
    $compileProvider.imgSrcSanitizationWhitelist /^\s*(https?|file|blob|cdvfile):|data:image\//
]