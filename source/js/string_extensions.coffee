if typeof String.prototype.hashCode == 'undefined'
  String::hashCode = () ->
    hash = 0
    i = undefined
    chr = undefined
    len = undefined
    return hash if @length is 0
    i = 0
    len = @length

    while i < len
      chr = @charCodeAt(i)
      hash = ((hash << 5) - hash) + chr
      hash |= 0 # Convert to 32bit integer
      i++
    hash

if typeof String.prototype.trim == 'undefined'
  String::trim = () ->
    String(this).replace(/^\s+|\s+$/g, '')

if typeof String.prototype.isPhrase == 'undefined'
  String::isPhrase = () ->
    @split(' ').length > 1

if typeof String.prototype.onlyAlphanumeric == 'undefined'
  String::onlyAlphanumeric = () ->
    @replace(/\W+/g, '')

if typeof String.prototype.sanitize == 'undefined'
  String::sanitize = () ->
    @trim().toLowerCase()
           .replace(/\s+/g, '')
           .onlyAlphanumeric()

if typeof String.prototype.splitIntoSegmentsOf == 'undefined'
  String::splitIntoSegmentsOf = (charactersPerSegment) ->
    @match RegExp(".{1,#{charactersPerSegment}}", 'g')

if typeof String.prototype.levenshteinDistance == 'undefined'
  String::levenshteinDistance = (toCompare) ->
    return toCompare.length  if @length is 0
    return @length  if toCompare.length is 0
    matrix = []
    
    # increment along the first column of each row
    i = undefined
    i = 0
    while i <= toCompare.length
      matrix[i] = [i]
      i++
    
    # increment each column in the first row
    j = undefined
    j = 0
    while j <= @length
      matrix[0][j] = j
      j++
    
    # Fill in the rest of the matrix
    i = 1
    while i <= toCompare.length
      j = 1
      while j <= @length
        if toCompare.charAt(i - 1) is @charAt(j - 1)
          matrix[i][j] = matrix[i - 1][j - 1]
        else
          # substitution
          # insertion
          matrix[i][j] = Math.min(matrix[i - 1][j - 1] + 1, Math.min(matrix[i][j - 1] + 1, matrix[i - 1][j] + 1)) # deletion
        j++
      i++
    matrix[toCompare.length][@length]