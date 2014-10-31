angular.module('app').directive "scaleFit", ['$timeout', ($timeout) ->
  restrict: "A"
  link: ($scope, $element, attrs) ->
    maxWidth = $element.innerWidth()

    maxWidth = attrs.scaleFit if attrs.scaleFit

    $timeout () ->
      $element.css 'white-space', 'nowrap'
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