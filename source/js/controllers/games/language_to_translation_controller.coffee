class Controller extends BaseGameController
  constructor: (@$scope, @$routeParams, @submissionHandler, @optionsGenerator, @$rootScope, @$location, @i18nService) ->
    super

    @$scope.labelForInstruction = @i18nService.get 'instructionSelectMatch'

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom.map (o) ->
      label: o.translation,
      answer_label: o.entry_word

angular.module('app').controller 'languageToTranslationController', ['$scope', '$routeParams', 'submissionHandlerService', 'optionsGeneratorService', '$rootScope', '$location', 'i18nService', Controller]