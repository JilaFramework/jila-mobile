angular.module('app').directive 'keepScrollPos', ($route, $window, $timeout, $location, $anchorScroll) ->

  scrollPosCache = {}

  (scope, element, attrs) ->
    scope.$on '$routeChangeStart', ->
      # store scroll position for the current view
      if $route.current
        scrollPosCache[$route.current.loadedTemplateUrl] = $('.page').scrollTop()
      return

    scope.$on '$routeChangeSuccess', ->
      # if hash is specified explicitly, it trumps previously stored scroll position
      if $location.hash()
        $anchorScroll()
      else
        # else get previous scroll position; if none, scroll to the top of the page
        if scrollPosCache[$route.current.loadedTemplateUrl]
          $timeout (->
            prevScrollPos = scrollPosCache[$route.current.loadedTemplateUrl]
            $('.page').scrollTop( prevScrollPos )
            return
          ), 0
      return

