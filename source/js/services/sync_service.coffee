class Service
  constructor: (@$http, @$q, @BACKEND_URL, @categoryService, @entryService, @imageCreditService, @downloadService) ->
  refresh: () =>
    deferred = @$q.defer()
    @$http.get("#{@BACKEND_URL}/api/sync/all")
          .then (res) => 
            @categoryService.clear()
            @entryService.clear()
            res.data.categories.forEach (c) =>
              for imageType of c.images
                c.images[imageType] = "img/missing-category.png" unless c.images[imageType]
              @categoryService.save c
              @downloadService.saveAssetsForCategory c
            res.data.entries.forEach (e) =>
              @entryService.save e
              @downloadService.saveAssetsForEntry e
            @imageCreditService.store res.data.image_credits
            deferred.resolve()
          , (err) =>
            deferred.reject()  

    return deferred.promise

angular.module('app').service 'syncService', ['$http', '$q', 'BACKEND_URL', 'categoryService', 'entryService', 'imageCreditService', 'downloadService', Service]