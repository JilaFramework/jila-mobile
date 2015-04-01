app = angular.module 'app', [
  'ngRoute',
  'ngTouch',
  'ngAnimate',
  'ngSanitize',
  'configuration',
  'angulartics',
  'angulartics.google.analytics',
  'pasvaz.bindonce'
]

app.config [
  '$compileProvider', ($compileProvider) ->
    $compileProvider.imgSrcSanitizationWhitelist /^\s*(https?|file|blob|cdvfile):|data:image\//
]

marked.setOptions
  breaks: true
  sanitize: true