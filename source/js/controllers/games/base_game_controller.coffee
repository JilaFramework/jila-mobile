class BaseGameController
  constructor: () ->
    @$rootScope.$emit 'navigationConfig', 
      searchAvailable: false
      labelForTitle: ''
      backAction: () =>
        goHome = () =>
          @$location.path('/games').search('')
          return

        confirmationMessage = @i18nService.get 'exitGameConfirmation'
        if navigator.notification
          navigator.notification.confirm confirmationMessage, (button) =>
            @$rootScope.$apply () -> 
              goHome() if button == 1
        else
          exit = confirm(confirmationMessage)
          goHome() if exit
          return

    @$scope.answer = null
    @$scope.selectedAnswer = null
    @$scope.options = []
    @$scope.labelForSubmit = 'Submit'

    @optionsGenerator.generateOptionsFor(this, @$routeParams.categoryId).then (generatedOptions) =>
      @$scope.answer = generatedOptions.answer
      @$scope.options = generatedOptions.options
      @onOptionsGenerated() if @onOptionsGenerated

    @$scope.sortableOptions =
      tolerance: 'pointer'
      axis: 'x'
      placeholder: 'sortable-placeholder'
      forcePlaceholderSize: true

    @$scope.select = (option) => @$scope.selectedAnswer = option
    @$scope.submitDisabled = @submitDisabled

    @$scope.listen = () => 
      @audioService.play(@$scope.answer.audio)
      return

    @$scope.submit = () =>
      @audioService.stop() if @audioService
      @submissionHandler.handleSubmissionFor this

  submitDisabled: () =>
    !@$scope.selectedAnswer

  categoryId: () =>
    @$routeParams.categoryId

  validOptionsFrom: (allOptions) ->
    allOptions

  displayOptions: (validOptionsFrom) ->
    validOptionsFrom

  validOptionsForAudioGameFrom: (allOptions) ->
    _.filter allOptions, (o) ->
      o.audio != null

  validOptionsForPictureGameFrom: (allOptions) ->
    _.filter allOptions, (o) -> 
      o.images.thumbnail != null

  jumbleAnswer: () =>
    baseAnswer = @$scope.answer.label.toLowerCase()

    if baseAnswer.isPhrase()
      splitSegments = baseAnswer.split(' ').map (s) -> 
        s.onlyAlphanumeric()
    else
      baseAnswer = baseAnswer.onlyAlphanumeric()
      numberSegments = if baseAnswer.length > 4 then 3 else 2
      segmentSize = Math.ceil baseAnswer.length / numberSegments
      splitSegments = baseAnswer.splitIntoSegmentsOf segmentSize
    
    jumbledSegments = _.sample(splitSegments, splitSegments.length)
    while baseAnswer.indexOf(jumbledSegments[0]) == 0
      jumbledSegments = _.sample(splitSegments, splitSegments.length)

    @$scope.jumbledAnswer = jumbledSegments
    return

  numOptionsRequired: () ->
    3

  hasValidAnswer: () -> 
    @$scope.answer == @$scope.selectedAnswer

  allowsAcceptableAnswer: () =>
    @hasAcceptableAnswer

  stringsAreEqual: (t1, t2) ->
    sanitized_t1 = t1.sanitize()
    sanitized_t2 = t2.sanitize()
    sanitized_t1 == sanitized_t2

  stringsAreEquivalent: (t1, t2) ->
    sanitized_t1 = t1.sanitize()
    sanitized_t2 = t2.sanitize()
    sanitized_t1[0] == sanitized_t2[0] && sanitized_t1.levenshteinDistance(sanitized_t2) < 2

  answerTextIsValid: () =>
    return true if @stringsAreEqual @$scope.answer.label, @$scope.selectedAnswer
    _.any @$scope.answer.alternate_answers, (alternate) =>
      @stringsAreEqual alternate, @$scope.selectedAnswer

  answerTextIsAcceptable: () =>
    return true if @stringsAreEquivalent @$scope.answer.label, @$scope.selectedAnswer
    _.any @$scope.answer.alternate_answers, (alternate) =>
      @stringsAreEquivalent alternate, @$scope.selectedAnswer

window.BaseGameController = BaseGameController