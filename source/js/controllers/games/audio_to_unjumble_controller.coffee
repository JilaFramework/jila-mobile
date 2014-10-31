class Controller extends BaseGameController
  constructor: (@$scope, @$routeParams, @submissionHandler, @optionsGenerator, @audioService, @$rootScope, @$location, @i18nService) ->
    super  

    @$scope.labelForInstruction = @i18nService.get 'instructionRearrange'

  validOptionsFrom: (allOptions) ->
    @validOptionsForAudioGameFrom(allOptions)

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom.map (o) ->
      label: o.entry_word
      audio: o.audio

  hasValidAnswer: () =>   
    @$scope.selectedAnswer = @$scope.jumbledAnswer.join ''
    @answerTextIsValid()

  numOptionsRequired: () ->
    1

  submitDisabled: () =>
    false

  onOptionsGenerated: () =>
    @jumbleAnswer()

angular.module('app').controller 'audioToUnjumbleController', ['$scope', '$routeParams', 'submissionHandlerService', 'optionsGeneratorService', 'audioService', '$rootScope', '$location', 'i18nService', Controller]