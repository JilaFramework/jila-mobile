angular.module('app').directive "slip", () ->
  restrict: "A"
  require: '?ngModel'
  link: ($scope, $element, attrs, ngModel) ->
    list = $element[0]

    list.addEventListener 'slip:beforewait', (e) ->
      e.preventDefault()

    list.addEventListener 'slip:reorder', (e) ->
      e.target.parentNode.insertBefore e.target, e.detail.insertBefore
      $scope.$apply () ->
        ngModel.$modelValue.splice e.detail.spliceIndex,
                                   0,
                                   ngModel.$modelValue.splice(e.detail.originalIndex, 1)[0]

    new Slip(list);