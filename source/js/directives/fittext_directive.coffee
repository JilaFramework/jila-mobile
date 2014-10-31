angular.module('app').directive "fitText", () ->
  restrict: "A"
  link: ($scope, $element, attrs) ->
    compressorStrength = 1.0

    if attrs.fitText
      compressorStrength = attrs.fitText

    $element.fitText(compressorStrength)