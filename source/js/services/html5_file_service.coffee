class Service
  constructor: (@$q) ->

  existingFor: (url) ->
    deferred = @$q.defer()

    deferred.resolve(url)

    return deferred.promise
  
  store: (blob, url) => 
    deferred = @$q.defer()

    fileReader = new FileReader()
    fileReader.onload = (e) ->
      deferred.resolve e.target.result

    # NOTE serve everything remotely, let the browser cache do its thing
    # fileReader.readAsDataURL(blob)

    return deferred.promise

angular.module('app').service 'fileService', ['$q', Service] unless window.isWebView