class Controller extends BaseGameController
  constructor: (@$scope, @$routeParams, @submissionHandler, @optionsGenerator, @$rootScope, @$location, @i18nService) ->
    super

    @$scope.labelForInstruction = @i18nService.get 'instructionMatchPicture'

  validOptionsFrom: (allOptions) ->
    @validOptionsForPictureGameFrom(allOptions)

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom.map (o) ->
      label: o.entry_word
      image: o.images.thumbnail

  numOptionsRequired: () ->
    4

  answerImage: () =>
    @$scope.answer.image

angular.module('app').controller 'picturesToLanguageController', ['$scope', '$routeParams', 'submissionHandlerService', 'optionsGeneratorService', '$rootScope', '$location', 'i18nService', Controller]