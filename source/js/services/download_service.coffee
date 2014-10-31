class Service
  constructor: (@$http, @$q, @categoryService, @entryService, @fileService) ->

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
          entry.images[imageType] = dataUri
          @entryService.save entry
    if entry.audio and entry.audio.indexOf('http') == 0
      @saveAsset(entry.audio).then (dataUri) =>
        entry.audio = "#{dataUri}"
        @entryService.save entry

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

  imageTypesFor: (model) =>
    imageTypes = []
    for imageType of model.images
      imageTypes.push imageType
    return imageTypes

angular.module('app').service 'downloadService', ['$http', '$q', 'categoryService', 'entryService', 'fileService', Service]