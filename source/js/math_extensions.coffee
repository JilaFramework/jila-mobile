if typeof Math.randomWithSeed == 'undefined'
  Math.randomWithSeed = (seed) ->
    x = Math.sin(seed) * 10000;
    x - Math.floor(x);