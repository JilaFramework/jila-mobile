class Service
  constructor: (@$http, @$q, @$rootScope, @categoryService, @entryService, @fileService) ->

  saveAssetsForCategory: (category) =>
    @imageTypesFor(category).forEach (imageType) =>
      if category.images[imageType] && category.images[imageType].indexOf('http') == 0
        @saveAsset(category.images[imageType]).then (dataUri) =>
          category.images[imageType] = dataUri
          @categoryService.save category

  saveAssetsForEntry: (entry) =>
    @imageTypesFor(entry).forEach (imageType) =>
      if entry.images[imageType] && entry.images[imageType].indexOf('http') == 0
        @saveAsset(entry.images[imageType]).then (dataUri) =>
          # dataUri = 'test' if not window.isWebView # testing in browser
          entry.images[imageType] = dataUri
          @entryService.save(entry).then () =>
            @$rootScope.$emit('saveAsset:success', {id:entry.id, format:imageType})
    @audioTypesFor(entry).forEach (audioType) =>
      if entry[audioType] and entry[audioType].indexOf('http') == 0
        @saveAsset(entry[audioType]).then (dataUri) =>
          # dataUri = 'test' if not window.isWebView # testing in browser
          entry[audioType] = dataUri
          @entryService.save(entry).then () =>
            @$rootScope.$emit('saveAsset:success', {id:entry.id, format:audioType})

  saveAsset: (url) =>
    deferred = @$q.defer()

    handleError = () ->
      console.log "Error saving asset for #{url}"
      deferred.reject()

    @fileService.existingFor(url).then (existingUri) ->
      deferred.resolve existingUri
    , () =>
      @$http.get(url, {responseType: 'arraybuffer'})
            .then (res) =>
              blob = new Blob([res.data], type: 'text/plain')

              @fileService.store(blob, url).then (uri) ->
                deferred.resolve uri
              , handleError
            , handleError

    return deferred.promise

  saveAssetForEntryId: (id, imageType) =>
    deferred = @$q.defer()
    console.log 'doing saveAssetForEntryId', id + ' ' + imageType
    @entryService.get(id).then (entry) =>
      if entry.images[imageType] && entry.images[imageType].indexOf('http') == 0
        @saveAsset(entry.images[imageType]).then (dataUri) =>
          entry.images[imageType] = dataUri
          @entryService.save entry
          deferred.resolve dataUri
    return deferred.promise

  imageTypesFor: (model) =>
    imageTypes = []
    for imageType of model.images
      imageTypes.push imageType
    return imageTypes

  audioTypesFor: (model) =>
    audioTypes = [
      'audio'
      'call_audio'
      'sentence_audio'
    ]

angular.module('app').service 'downloadService', ['$http', '$q', '$rootScope', 'categoryService', 'entryService', 'fileService', Service]