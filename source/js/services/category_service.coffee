class Service
  constructor: (@$q) ->
  all: () =>
    deferred = @$q.defer()
    Lawnchair {name: 'categories', adapter: 'dom'}, (store) ->
      store.all (categories) ->
        deferred.resolve categories.map (e) -> e.value
    return deferred.promise
  get: (categoryId) =>
    deferred = @$q.defer()
    Lawnchair {name: 'categories', adapter: 'dom'}, (store) ->
      store.get categoryId, (category) ->
        deferred.resolve category.value
    return deferred.promise
  save: (category) =>
    Lawnchair {name: 'categories', adapter: 'dom'}, (store) ->
      store.save {key: category.id, value: category}
  clear: () =>
    Lawnchair {name: 'categories', adapter: 'dom'}, (store) ->
      store.nuke()

angular.module('app').service 'categoryService', ['$q', Service]