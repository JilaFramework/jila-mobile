EN =
  splashTitle: 'Thipe'
  splashSubTitle: 'birds'
  homeTitle: 'Thipe'
  homeDictionary: 'Dictionary'
  homeCategories: 'Explore'
  homeLearn: 'Games'
  homeCommon: 'Common Phrases'
  homeWordOfTheDay: 'Thipe Of The Day'
  homeAbout: 'About'
  homeWarningTitle: 'Warning'
  homeWarningMessage: 'This app may contain images and voices of Aboriginal and
    Torres Strait Islander people who have passed away'
  categoriesTitle: 'Pick A Category'
  dictionaryTitle: 'Dictionary'
  gamesTitle: 'Game Categories'
  commonTitle: 'Common Phrases'
  wordOfTheDayTitle: 'Thipe Of The Day'
  aboutTitle: 'About'
  aboutHistoryTab: 'History'
  aboutResourcesTab: 'Resources'
  aboutLocationTab: 'Location'
  aboutPartnersTab: 'Partners'
  aboutCreditsTab: 'Credits'
  placeholderSearch: 'Search'
  instructionSelectMatch: 'Tap the matching word/phrase'
  instructionMatchPicture: 'Tap the matching picture'
  instructionTranslateAudio: 'Translate what you hear'
  instructionTranslateWord: 'Translate the word/phrase'
  instructionRearrange: 'Re-arrange the tiles to match'
  exitGameConfirmation: 'Are you sure you want to exit? This will end your game'
  placeholderAnswer: 'Type your answer here'
  roundTitleSuccess: 'Congratulations!'
  roundTitleFailure: 'Oh no!'
  roundMessageSuccess: 'You were right!'
  roundMessageSuccessWithWarning: 'Well done, be careful with spelling though'
  roundMessageFailure: 'The correct answer was '
  sessionTitleSuccess: 'Congratulations!'
  sessionMessageSuccess: 'You\'re on your way!'
  sessionTitleFailure: 'Oh no!'
  sessionMessageFailure: 'You\'ve run out of chances! Better luck next time!'
  acknowledgeButton: 'Ok'
  syncFailureOfflineMessage: 'Unable to update content'
  syncFailureRetryMessage: 'Unable to update content. Check your network connection and retry'
  syncRetryButtonMessage: 'Retry Sync'

class Service
  constructor: () ->
    @defaultDictionary = EN
    @currentDictionary = @defaultDictionary
  get: (key) =>
    @currentDictionary[key]


angular.module('app').service 'i18nService', [Service]