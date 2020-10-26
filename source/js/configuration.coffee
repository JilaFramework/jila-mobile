BACKEND_URL = 'https://gooniyandi-backend.herokuapp.com'

angular.module('configuration', [])
       .constant('SPLASH_SCREEN_DELAY', 2000)
       .constant('BACKEND_URL', BACKEND_URL)
       .constant('GAMES_PER_ROUND', 20)
       .constant('LIVES_PER_ROUND', 3)
       .constant('COMMON_CATEGORY_ID', 1)