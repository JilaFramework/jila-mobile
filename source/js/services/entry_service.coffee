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
  entries_for_letter: (letter) =>
    deferred = @$q.defer()
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) ->
      store.all (entry_data) ->
        entries = entry_data.map (e) -> e.value
        deferred.resolve entries.filter (e) -> e.entry_word[0].toLowerCase() == letter.toLowerCase()
    return deferred.promise

  save: (entry) =>
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) ->
      store.save {key: entry.id, value: entry}
  search_for: (query) =>
    deferred = @$q.defer()
    entries = []
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) =>
      store.where "record.value.meaning.toLowerCase().indexOf('#{query.toLowerCase()}') !== -1", (result) =>
        if result.length == 0
          @$analytics.eventTrack 'SearchNotFound',
              category: 'SearchNotFound'
              label: query
        entries = entries.concat result
      store.where "record.value.entry_word.toLowerCase().indexOf('#{query.toLowerCase()}') !== -1", (result) =>
        if result.length == 0
          @$analytics.eventTrack 'SearchNotFound',
              category: 'SearchNotFound'
              label: query
        entries = entries.concat result
    deferred.resolve entries.map (e) -> e.value
    return deferred.promise
  clear: () =>
    Lawnchair {name: 'entries', adapter: 'dom'}, (store) ->
      store.nuke()

angular.module('app').service 'entryService', ['$q', '$analytics', Service]
