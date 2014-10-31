class Controller extends BaseGameController
  constructor: (@$scope, @$routeParams, @audioService, @submissionHandler, @optionsGenerator, @$rootScope, @$location, @i18nService) ->
    super

    @$scope.labelForInstruction = @i18nService.get 'instructionTranslateAudio'
    @$scope.labelForPlaceholder = @i18nService.get 'placeholderAnswer'

  validOptionsFrom: (allOptions) ->
    @validOptionsForAudioGameFrom(allOptions)

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom.map (o) ->
      label: o.translation,
      alternate_answers: o.alternate_translations,
      audio: o.audio

  hasValidAnswer: () =>   
    @answerTextIsValid()

  hasAcceptableAnswer: () =>
    @answerTextIsAcceptable()

  numOptionsRequired: () ->
    1

angular.module('app').controller 'audioToTranslationTextController', ['$scope', '$routeParams', 'audioService', 'submissionHandlerService', 'optionsGeneratorService', '$rootScope', '$location', 'i18nService', Controller]