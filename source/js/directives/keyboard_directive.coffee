angular.module('app').directive "detectKeyboard", [() ->
  restrict: "A"
  link: ($scope, $element, attrs) ->
    targetElement = $('body')

    $scope.$on '$viewContentLoaded', () ->
      $('input,textarea').on 'focus', () ->
        targetElement.addClass 'keyboard-visible'

      $('input,textarea').on 'blur', () ->
        targetElement.removeClass 'keyboard-visible'
  ]