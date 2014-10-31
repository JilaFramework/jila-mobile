class Controller extends BaseGameController
  constructor: (@$scope, @$routeParams, @audioService, @submissionHandler, @optionsGenerator, @$rootScope, @$location, @i18nService) ->
    super

    @$scope.labelForInstruction = @i18nService.get 'instructionSelectMatch'

  validOptionsFrom: (allOptions) ->
    @validOptionsForAudioGameFrom(allOptions)

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom.map (o) ->
      label: o.translation,
      audio: o.audio

angular.module('app').controller 'audioToTranslationController', ['$scope', '$routeParams', 'audioService', 'submissionHandlerService', 'optionsGeneratorService', '$rootScope', '$location', 'i18nService', Controller]