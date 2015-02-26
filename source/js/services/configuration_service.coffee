class Service
  constructor: (@$q) ->
  initialSyncComplete: () => 
    if window.localStorage['initialSyncComplete'] then true else false
  initialSyncCompleted: () =>
    window.localStorage['initialSyncComplete'] = true

angular.module('app').service 'configurationService', ['$q', Service]