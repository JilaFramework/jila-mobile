angular.module('app').directive "slickCarousel", () ->
  restrict: "A"
  link: ($scope, $element, attrs) ->
    $scope.content = $element.slick 
                       arrows: false
                       infinite: false
                       onAfterChange: (state) ->
                         $scope.$apply () ->                        
                           $scope.indexChanged state.currentSlide
                           return

    setTimeout () ->
      newHeight = $(window).height() - $('.navigation').height() - $('.tab-headers').height();                       
      $element.find('.tab-page').height(newHeight) 