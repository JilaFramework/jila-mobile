describe 'BaseGameController', () ->
  controller = null

  $scope = {}
  $rootScope = {}
  $q = null
  deferred = null

  submissionHandler = 
    handleSubmissionFor: jasmine.createSpy('submissionHandler::handleSubmissionFor')
  optionsGenerator = 
    generateOptionsFor: () ->
      deferred = $q.defer()
      deferred.promise

  audioService = 
    play: jasmine.createSpy('audioService::play')
  routeParams = 
    categoryId: 37

  class TestController extends BaseGameController
    constructor: (@$scope, @$routeParams, @submissionHandler, @optionsGenerator, @audioService, @$rootScope) ->
      super

  beforeEach module('app')

  beforeEach inject (_$q_, _$rootScope_, _$httpBackend_) ->
    $q = _$q_
    $rootScope = _$rootScope_
    _$httpBackend_.whenGET('partials/splash.html').respond(200);

    spyOn(optionsGenerator, 'generateOptionsFor').and.callThrough()
    controller = new TestController($scope, routeParams, submissionHandler, optionsGenerator, audioService, $rootScope)

  describe 'initially', () ->
    it 'should default the answer and options', () ->
      expect(controller.$scope.answer).toBeNull()
      expect(controller.$scope.selectedAnswer).toBeNull()
      expect(controller.$scope.options).toEqual []

    it 'should get the options generated', () ->
      expect(optionsGenerator.generateOptionsFor).toHaveBeenCalledWith(controller, 37)

    describe 'the options filters', () -> 
      it 'should provide a default pass-through for validOptions', () ->
        proposedOptions = [1,2,3]

        validOptions = controller.validOptionsFrom proposedOptions

        expect(validOptions).toBe proposedOptions

      it 'should provide a default pass-through for displayOptions', () ->
        proposedOptions = [1,2,3]

        displayOptions = controller.displayOptions proposedOptions

        expect(displayOptions).toBe proposedOptions

    describe 'when the options are returned', () ->

      beforeEach () ->
        deferred.resolve 
          answer: 1
          options: [1,2,3]
        $rootScope.$apply()

      it 'should set the answer', () ->
        expect($scope.answer).toEqual(1)

      it 'should set the options', () -> 
        expect($scope.options).toEqual([1,2,3])

  describe 'filtering audio options', () ->
    valid = audio: 'monkey.m4a'
    invalid = audio: null
    allOptions = [valid, invalid]

    it 'should filter out those that are missing audio', () ->
      filteredOptions = controller.validOptionsForAudioGameFrom allOptions

      expect(_.contains(filteredOptions, valid)).toBe true
      expect(_.contains(filteredOptions, invalid)).toBe false

  describe 'filtering image options', () ->
    valid = 
      images: 
        thumbnail: 'janung.png'
    invalid = 
      images:
        thumbnail: null
    allOptions = [valid, invalid]

    it 'should filter out those that are missing pictures', () ->
      filteredOptions = controller.validOptionsForPictureGameFrom allOptions

      expect(_.contains(filteredOptions, valid)).toBe true
      expect(_.contains(filteredOptions, invalid)).toBe false

  describe 'jumbling the answer', () ->
    describe 'when the answer is a sentence', () ->
      beforeEach () ->
        $scope.answer = 
          label: 'Ngaji mingan?'

        controller.jumbleAnswer()

      it 'should just jumble the words', () ->
        expect($scope.jumbledAnswer).toBeDefined()
        expect($scope.jumbledAnswer.length).toBe 2
        expect($scope.jumbledAnswer[0]).toBe 'mingan'

    describe 'when the answer is a word less than or equal to 4 characters', () ->
      beforeEach () ->
        $scope.answer = 
          label: 'Gagi'

        controller.jumbleAnswer()

      it 'should split it into 2 pieces', () ->
        expect($scope.jumbledAnswer.length).toBe 2

    describe 'when the answer is a word longer than 4 characters', () ->
      beforeEach () ->
        $scope.answer = 
          label: 'Ngalminyaminya'

        controller.jumbleAnswer()

      it 'should split it into 3 pieces', () ->
        expect($scope.jumbledAnswer.length).toBe 3

    it 'should remove non alphanumeric characters', () ->
      $scope.answer = label: 'Nganyja?'
      controller.jumbleAnswer()
      expect(_.all($scope.jumbledAnswer, (seg) -> seg.indexOf('?') == -1)).toBe true

  describe 'when comparing answer text', () ->
    beforeEach () ->
      spyOn(controller, 'stringsAreEqual').and.callThrough()
      spyOn(controller, 'stringsAreEquivalent').and.callThrough()
      controller.$scope.answer = 
        label: 'Blue-winged Kookaburra'
        alternate_answers: ['Kookaburra', 'Monkey']
      controller.$scope.selectedAnswer = 'Monkey1'

    describe 'for equality', () ->
      it 'should try the answer and all the alternate answers', () ->
        controller.answerTextIsValid()
        expect(controller.stringsAreEqual).toHaveBeenCalledWith('Blue-winged Kookaburra', 'Monkey1')
        expect(controller.stringsAreEqual).toHaveBeenCalledWith('Kookaburra', 'Monkey1')
        expect(controller.stringsAreEqual).toHaveBeenCalledWith('Monkey', 'Monkey1')

    describe 'for equivalence', () ->
      it 'should try the answer and all the alternate answers', () ->
        controller.answerTextIsAcceptable()
        expect(controller.stringsAreEquivalent).toHaveBeenCalledWith('Blue-winged Kookaburra', 'Monkey1')
        expect(controller.stringsAreEquivalent).toHaveBeenCalledWith('Kookaburra', 'Monkey1')
        expect(controller.stringsAreEquivalent).toHaveBeenCalledWith('Monkey', 'Monkey1')

  describe 'when comparing strings for equality', () ->
    answerText = 'Blue-winged Kookaburra'

    it 'should fail if the spelling is incorrect', () ->
      expect(controller.stringsAreEqual(answerText, 'Blue-winged Kokaburra')).toBe false

    it 'should ignore spaces', () ->
      expect(controller.stringsAreEqual(answerText, 'Blue-wingedKookaburra')).toBe true

    it 'should ignore capitalisation', () ->
      expect(controller.stringsAreEqual(answerText, 'Blue-winged kookaburra')).toBe true

    it 'should ignore non-alphanumeric characters', () ->
      expect(controller.stringsAreEqual(answerText, 'Blue----winged Kookaburra')).toBe true

  describe 'when comparing strings for equivalence', () ->
    answerText = 'Blue-winged Kookaburra'

    it 'should allow a mis-typed character if the first character is correct', () ->
      expect(controller.stringsAreEquivalent(answerText, 'Blue-winged Kokaburra')).toBe true

    it 'should not allow a mis-typed character if the first character is incorrect', () ->
      expect(controller.stringsAreEquivalent(answerText, 'Dlue-winged Kookaburra')).toBe false

    it 'should not allow 2 mis-typed characters', () ->
      expect(controller.stringsAreEquivalent(answerText, 'Blue-winged Kkaburra')).toBe false