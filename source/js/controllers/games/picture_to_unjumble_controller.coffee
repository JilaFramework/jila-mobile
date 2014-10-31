class Controller extends BaseGameController
  constructor: (@$scope, @$routeParams, @submissionHandler, @optionsGenerator, @$rootScope, @$location, @i18nService) ->
    super  

    @$scope.labelForInstruction = @i18nService.get 'instructionRearrange'

  validOptionsFrom: (allOptions) ->
    @validOptionsForPictureGameFrom(allOptions)

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom.map (o) ->
      label: o.entry_word,
      image: o.images.thumbnail

  hasValidAnswer: () =>   
    @$scope.selectedAnswer = @$scope.jumbledAnswer.join ''
    @answerTextIsValid()

  numOptionsRequired: () ->
    1

  submitDisabled: () =>
    false

  onOptionsGenerated: () =>
    @jumbleAnswer()

angular.module('app').controller 'pictureToUnjumbleController', ['$scope', '$routeParams', 'submissionHandlerService', 'optionsGeneratorService', '$rootScope', '$location', 'i18nService', Controller]