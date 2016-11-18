class Controller
  constructor: (@$q, @$timeout, $scope, $rootScope, $filter, @downloadService, @downloadManagerService, @entryService, $location, i18nService) ->
    $rootScope.$emit 'navigationConfig',
      labelForTitle: 'Downloads',
      backAction: () ->
        $location.path('/home')

    $scope.chartOptions = {
      data: [{
        downloaded: 0,
        remaining:  0
      }],
      dimensions: {
        downloaded: {},
        remaining:  {}
      },
      chart : {
        legend:   { hide: true },
        tooltip:  { show: false },
        size:     { height: 150, width: 150 },
        color:    { pattern: ['#50DC50', '#FFFAFF'] },
        data: {
          type: 'donut',
          groups: [['downloaded', 'remaining']]
        }
      }
    }
    # $scope.instance = null

    # $scope.downloadingAssets = i18nService.get 'downloadingAssets'
    # $scope.downloadingAssetsComplete = i18nService.get 'downloadingAssetsComplete'

    $scope.downloading = true
    $scope.toggleDownloading = () =>
      $scope.downloading = !$scope.downloading
      @download($scope.entriesIndex)

    $scope.entries = []
    $scope.entriesIndex = []

    # use all entries for the page display - later do this in chunks like the category service
    @entryService.all().then (entries) =>
      $scope.entries = entries

    # a simpler collection of entry ids and asset count,
    # to iterate and splice off when assets are downloaded
    @downloadManagerService.getIndex().then (entries) =>
      $scope.entriesIndex = entries
      console.log 'getting index has', entries.length
      if entries.length > 0
        @download($scope.entriesIndex)
      else
        $scope.chartOptions.data[0].remaining = 0
        $scope.chartOptions.data[0].downloaded = $scope.entries.length


    $rootScope.$on 'saveAsset:success', (e, obj) =>
      console.log 'DMC received saveAsset:success', obj.id + ' ' + obj.format
      # update scope entries so the ui can update asset status classes
      @entryService.get(obj.id).then (entry) =>
        for e, i in $scope.entries
          if e.id == entry.id
            $scope.entries[i] = entry
      # decrement asset count for this entry
      found = $filter('filter')($scope.entriesIndex, { id: obj.id }, true)
      if found[0] and found[0].assets
        --found[0].assets
        # no more assets for this entry
        if found[0].assets == 0
          # remove it from the list
          for entryAssets, i in $scope.entriesIndex
            if entryAssets && entryAssets.id == obj.id
              $scope.entriesIndex.splice i, 1
        console.log 'now we have', $scope.entriesIndex.length
        # update the chart values
        $scope.chartOptions.data[0].remaining = $scope.entriesIndex.length
        $scope.chartOptions.data[0].downloaded = $scope.entries.length - $scope.entriesIndex.length

        return if not $scope.downloading
        @download($scope.entriesIndex) if $scope.entriesIndex.length > 0



  download: (entries) ->
    if entries[0]
      @entryService.get(entries[0].id).then (entry) =>
        @downloadService.saveAssetsForEntry entry


angular.module('app').controller 'downloadManagerController', ['$q', '$timeout', '$scope', '$rootScope', '$filter', 'downloadService', 'downloadManagerService', 'entryService', '$location', 'i18nService', Controller]