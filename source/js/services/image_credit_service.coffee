class Service
  constructor: (@$q) ->
  all: () =>
    deferred = @$q.defer()
    storedCredits = window.localStorage['imageCredits']

    deferred.resolve _.uniq(JSON.parse( storedCredits ).map (e) -> e.attribution_text) if storedCredits

    return deferred.promise
  store: (imageCredits) =>
    window.localStorage['imageCredits'] = JSON.stringify(imageCredits)
    return

angular.module('app').service 'imageCreditService', ['$q', Service]