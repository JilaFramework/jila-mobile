
BACKEND_URL = 'http://jila-arrernte-admin.herokuapp.com'

angular.module('configuration', [])
       .constant('SPLASH_SCREEN_DELAY', 1000)
       .constant('BACKEND_URL', BACKEND_URL)
       .constant('GAMES_PER_ROUND', 20)
       .constant('LIVES_PER_ROUND', 3)
       .constant('COMMON_CATEGORY_ID', 1)