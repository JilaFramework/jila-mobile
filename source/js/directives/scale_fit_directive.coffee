angular.module('app').directive "scaleFit", ['$timeout', ($timeout) ->
  restrict: "A"
  link: ($scope, $element, attrs) ->

    # replace hyphens with non-breaking to prevent separation of suffixes
    $scope.$watch 'entries', () ->
      $scope.entry.entry_word = $scope.entry.entry_word.replace /-/g, '\u2011'

    maxWidth = $element.innerWidth()

    maxWidth = attrs.scaleFit if attrs.scaleFit

    $timeout () ->
      $element.css 'white-space', 'normal'
      childSpan = $element.find('span')
      spanWidth = childSpan.innerWidth()

      if spanWidth > maxWidth
        scale = maxWidth / spanWidth
        difference = (spanWidth - spanWidth * scale) / 2
        childSpan.css 'display', 'inline-block'
        childSpan.css 'transform-origin', 'left'
        childSpan.css 'transform', "scale(#{scale})"
        childSpan.innerWidth "#{maxWidth}px"

      return
    , 100
]