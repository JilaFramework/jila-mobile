angular.module('app').directive "detectSwipeBack", ['$animate', ($animate) ->
  restrict: "A"
  link: ($scope, $element, attrs) ->
    $element.on '$animate:close', () ->
      $('body').removeClass 'swipe-back'
  ]