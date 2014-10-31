class Service
  constructor: () ->
  load: (file) =>
    console.log "Loading #{file}"
    @media.stop() if @media
    @media.release() if @media
    @media = new Media file
      , null
      , (e) -> console.log e 
    return
  play: (file) =>
    console.log "Playing #{file}"
    @load(file)
    @media.play()
  stop: () =>
    @media.stop() if @media
    @media.release() if @media
    

angular.module('app').service 'audioService', [Service] if window.isWebView