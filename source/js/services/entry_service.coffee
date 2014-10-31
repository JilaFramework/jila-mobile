class Service
  constructor: (@$q, @$analytics) ->
  entries_for: (categoryId) =>
    deferred = @$q.defer()
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) =>
      store.where "_.contains(record.value.categories, #{categoryId})", (entries) ->
        deferred.resolve entries.map (e) -> e.value
    return deferred.promise
  get: (entryId) => 
    deferred = @$q.defer()
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) ->
      store.get entryId, (entry) ->
        deferred.resolve entry.value
    return deferred.promise
  all: () => 
    deferred = @$q.defer()
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) ->
      store.all (entries) ->
        deferred.resolve entries.map (e) -> e.value
    return deferred.promise
  save: (entry) =>
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) ->
      store.save {key: entry.id, value: entry}
  search_for: (query) =>
    deferred = @$q.defer()
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) =>
      store.where "record.value.translation.toLowerCase().indexOf('#{query.toLowerCase()}') !== -1", (entries) =>
        if entries.length == 0
          @$analytics.eventTrack 'SearchNotFound',
              category: 'SearchNotFound'
              label: query
        deferred.resolve entries.map (e) -> e.value
    return deferred.promise
  clear: () =>
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) ->
      store.nuke()

angular.module('app').service 'entryService', ['$q', '$analytics', Service]