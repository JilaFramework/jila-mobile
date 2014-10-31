window.isWebView = if document.URL.indexOf('http://') == -1 then true else false

class Platform
  constructor: () ->
    @readyFlag = false
    @readyCallbacks = []

    if window.isWebView
      document.addEventListener 'deviceready', () =>
        @readyFlag = true
        @readyCallbacks.forEach (cb) -> cb()
        @readyCallbacks = []
    else  
      @readyFlag = true

  isReady: (callback) ->
    if @readyFlag
      callback()
    else
      @readyCallbacks.push callback

window.Platform = new Platform()