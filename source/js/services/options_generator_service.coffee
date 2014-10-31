class Service
  constructor: (@entryService, @$q) ->

  generateOptionsFor: (controller, categoryId) =>
    deferred = @$q.defer()

    @entryService.entries_for(categoryId).then (allOptions) ->
      validOptions = controller.validOptionsFrom(allOptions)
      displayOptions = controller.displayOptions(validOptions)
      options = _.sample displayOptions, controller.numOptionsRequired()
      deferred.resolve
        answer: options[_.random(0, options.length-1)]
        options: options
      return

    deferred.promise

angular.module('app').service 'optionsGeneratorService', ['entryService', '$q', Service]