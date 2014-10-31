class Controller extends BaseGameController
  constructor: (@$scope, @$routeParams, @submissionHandler, @optionsGenerator, @$rootScope, @$location, @i18nService) ->
    super

    @$scope.labelForInstruction = @i18nService.get 'instructionSelectMatch'

  validOptionsFrom: (allOptions) -> 
    @validOptionsForPictureGameFrom(allOptions)

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom.map (o) ->
      label: o.entry_word,
      image: o.images.thumbnail

angular.module('app').controller 'pictureToLanguageController', ['$scope', '$routeParams', 'submissionHandlerService', 'optionsGeneratorService', '$rootScope', '$location', 'i18nService', Controller]