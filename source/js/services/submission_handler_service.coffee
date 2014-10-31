class Service
  constructor: (@$location, @gameService, @$analytics, @i18nService) ->

  handleSubmissionFor: (controller) =>
    if controller.hasValidAnswer()
      resultTitle = @i18nService.get 'roundTitleSuccess'
      explanation = @i18nService.get 'roundMessageSuccess'
      gameStatus = @gameService.success()
    else if controller.allowsAcceptableAnswer() and controller.hasAcceptableAnswer()
      resultTitle = @i18nService.get 'roundTitleSuccess'
      explanation = @i18nService.get 'roundMessageSuccessWithWarning'
      gameStatus = @gameService.success()
    else
      resultTitle = @i18nService.get 'roundTitleFailure'
      explanation = @i18nService.get 'roundMessageFailure'
      gameStatus = @gameService.fail()
      if controller.answerImage
        correctImage = controller.answerImage()
      else
        explanation = "#{explanation}'#{controller.$scope.answer.label}'"
      @$analytics.eventTrack 'IncorrectAnswer',
        category: 'IncorrectAnswer'
        label: controller.$scope.answer.label

    status = 
      resultTitle: resultTitle
      explanation: explanation
      correctImage: correctImage
      gameStatus: gameStatus

    @$location.path("/games/#{controller.categoryId()}/result").search("status=#{JSON.stringify(status)}&games=#{@$location.search()['games']}")

angular.module('app').service 'submissionHandlerService', ['$location', 'gameService', '$analytics', 'i18nService', Service]