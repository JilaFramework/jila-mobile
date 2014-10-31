angular.module('app').directive "detectBack", ['$animate', ($animate) ->
  restrict: "A"
  link: ($scope, $element, attrs) ->
    $element.on '$animate:close', () ->
      window.backInProgress-- if window.backInProgress > 0
      $('body').removeClass 'back' if window.backInProgress == 0
  ]