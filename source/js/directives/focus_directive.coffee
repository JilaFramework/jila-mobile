angular.module('app').directive "focusWhen", () ->
  restrict: "A"
  scope:
    focusValue: "=focusWhen"

  link: ($scope, $element, attrs) ->
    $scope.$watch "focusValue", (currentValue, previousValue) ->
      if currentValue is true and not previousValue
        $element[0].focus()
      else $element[0].blur()  if currentValue is false and previousValue
      return
    return