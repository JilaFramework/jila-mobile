class Service
  constructor: (@$q, @$rootScope, @$timeout, @downloadService, @entryService) ->

  clear: () =>
    console.log 'downloadManagerService clear'

  getIndex: () ->
    deferred = @$q.defer()
    @entryService.all().then (entries) =>
      # entry assets array
      # if window.localStorage[@ENTRIES_ASSET_REGISTER_SAVED_KEY]
      #   console.log 'getting from localStorage'
      #   stored = window.localStorage[@ENTRIES_ASSET_REGISTER_KEY]
      #   entriesIndex = JSON.parse(stored) if stored
      # else
      console.log 'getting fresh'
      entriesIndex = entries.map (e) =>
        return {id:e.id, assets: @countAssets(e)}
      # @save entriesIndex
      filtered = entriesIndex.filter (x) -> x.assets > 0
      deferred.resolve filtered
    return deferred.promise

  countAssets: (entry) ->
    assets = 0
    @downloadService.imageTypesFor(entry).forEach (imageType) =>
      ++assets if entry.images[imageType] && entry.images[imageType].indexOf('http') == 0
    @downloadService.audioTypesFor(entry).forEach (audioType) =>
      ++assets if entry[audioType] && entry[audioType].indexOf('http') == 0
    return assets

angular.module('app').service 'downloadManagerService', ['$q', '$rootScope', '$timeout', 'downloadService', 'entryService', Service]
