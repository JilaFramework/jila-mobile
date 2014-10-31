describe 'optionsGeneratorService', () ->
  service = null
  $rootScope = null
  $q = null
  deferredEntries = null

  answer = null
  options = null

  possibleOptions = [1,2,3,4]

  entryService = 
    entries_for: () -> 
      deferredEntries = $q.defer()
      deferredEntries.promise

  controller =
    $scope: {},
    validOptionsFrom: (entries) -> entries
    displayOptions: (entries) -> entries
    numOptionsRequired: () -> 3

  beforeEach module 'app'

  beforeEach module ($provide) ->
    $provide.value('entryService', entryService)
    return

  beforeEach inject (_$q_, _$rootScope_, _optionsGeneratorService_) ->
    $q = _$q_
    $rootScope = _$rootScope_
    service = _optionsGeneratorService_
    return

  describe 'when generating options', () ->

    beforeEach () ->
      spyOn(entryService, 'entries_for').and.callThrough()
      service.generateOptionsFor(controller, 3).then (returnedOptions) ->
        answer = returnedOptions.answer
        options = returnedOptions.options
        return
      return

    it 'should get the entries from the entryService', () ->
      expect(entryService.entries_for).toHaveBeenCalledWith(3)

    describe 'then when they are returned', () ->
      beforeEach () ->
        spyOn(controller, 'validOptionsFrom').and.callThrough()
        spyOn(controller, 'displayOptions').and.callThrough()

        deferredEntries.resolve possibleOptions
        $rootScope.$apply()
        return

      it 'should ask the controller to transform the options into what it needs', () ->
        expect(controller.validOptionsFrom).toHaveBeenCalledWith possibleOptions
        expect(controller.displayOptions).toHaveBeenCalledWith possibleOptions  

      it 'should return them via the promise', () ->
        expect(options).not.toBeNull()
        expect(answer).not.toBeNull()

      it 'should take the required number of options', () ->
        expect(options.length).toBe 3

      it 'should pick an answer from the options', () ->
        expect(_.contains(options, answer)).toBe true




