class Controller extends BaseGameController
  constructor: (@$scope, @$routeParams, @submissionHandler, @optionsGenerator, @$rootScope, @$location, @i18nService) ->
    super

    @$scope.labelForInstruction = @i18nService.get 'instructionTranslateWord'
    @$scope.labelForPlaceholder = @i18nService.get 'placeholderAnswer'

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom.map (o) ->
      label: o.translation,
      alternate_answers: o.alternate_translations,
      answer_label: o.entry_word

  hasValidAnswer: () =>   
    @answerTextIsValid()

  hasAcceptableAnswer: () =>
    @answerTextIsAcceptable()

  numOptionsRequired: () ->
    1

angular.module('app').controller 'languageToTranslationTextController', ['$scope', '$routeParams', 'submissionHandlerService', 'optionsGeneratorService', '$rootScope', '$location', 'i18nService', Controller]