angular.module('app').directive "journey", ['$timeout', ($timeout) ->
  restrict: "A"
  link: ($scope, $element, attrs) ->
    $scope.$watch 'categories', () ->
      windowWidth = $(window).width()
      height = 100
      children = $element.children()

      $element.height(children.length * height)

      children.each (idx, c) ->
        c = $(c)
        pattern = idx % 6
         
        xOffset = switch pattern
          when 0 then 10
          when 1 then 45
          when 2 then 70
          when 3 then 35
          when 4 then 15
          when 5 then 55
        left = xOffset / 100 * windowWidth
        c.css('left', "#{left}px") 

        yOffset = switch pattern
          when 0 then 8
          when 1 then 0
          when 2 then 5
          when 3 then -25
          when 4 then 2
          when 5 then 0
        top = height * idx + yOffset + height / 2
        c.css('top', "#{top}px")

        track = c.find('.track')
        top = left = 0
        switch pattern
          when 0
            left = 90
          when 1
            top = 45
            left = 45
          when 2
            left = -45
          when 3
            top = 45
          when 4
            left = 90
          when 5
            left = -90
        track.css 'top', "#{top}px"
        track.css 'left', "#{left}px"

      i = 0
      while i < children.length - 1
        track = $(children[i]).find('.track')

        dx = children[i].offsetLeft - children[i+1].offsetLeft
        dy = children[i].offsetTop - children[i+1].offsetTop
        angle = Math.atan2(dy, dx) * 180 / Math.PI + 270

        track.css('transform', "rotate(#{angle}deg)")

        distance = Math.sqrt(Math.pow(dx,2) + Math.pow(dy,2))
        track.height(distance)
        i++

]