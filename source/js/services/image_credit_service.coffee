class Service
  constructor: (@$q) ->
  all: () => 
    deferred = @$q.defer()
    storedCredits = window.localStorage['imageCredits']

    deferred.resolve JSON.parse(storedCredits) if storedCredits

    return deferred.promise
  store: (imageCredits) =>
    window.localStorage['imageCredits'] = JSON.stringify(imageCredits)
    return

angular.module('app').service 'imageCreditService', ['$q', Service]