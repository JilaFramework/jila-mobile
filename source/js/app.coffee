app = angular.module 'app', [
  'ngRoute',
  'ngTouch',
  'ngAnimate',
  'ngSanitize',
  'configuration',
  'angulartics',
  'angulartics.google.analytics',
  'pasvaz.bindonce',
  'angularChart'
]

app.config [
  '$compileProvider', ($compileProvider) ->
    $compileProvider.imgSrcSanitizationWhitelist /^\s*(https?|file|blob|cdvfile):|data:image\//
]
app.run [
  'downloadService', (downloadService) ->
    # when a lazy-loaded image loads, save it locally
    document.addEventListener 'lazybeforeunveil', (e) ->
      id = e.target.getAttribute('data-id')
      imageType = e.target.getAttribute('data-imagetype')
      downloadService.saveAssetForEntryId(id, imageType)
]
marked.setOptions
  breaks: true
  sanitize: true
