class Service
  constructor: () ->
    @player = $('.player')
    @player.jPlayer
      loadeddata: (event) =>
      timeupdate: (event) =>
      ended: (event) =>
  load: (file) ->
    console.log "Loading #{file}"
    @player
      .jPlayer 'stop'
      .jPlayer 'setMedia', 
        mp3: file,
        m4a: file
  play: (file) =>
    @load(file)
    console.log "Playing #{file}"
    @player.jPlayer('play')
  stop: () =>
    @player.jPlayer 'stop'

angular.module('app').service 'audioService', [Service] unless window.isWebView