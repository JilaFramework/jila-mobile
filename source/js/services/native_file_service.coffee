class Service
  constructor: (@$q) ->

  filenameFor: (url) ->
    "#{url.hashCode()}"

  existingFor: (url) =>
    deferred = @$q.defer()

    handleError = () -> deferred.reject()

    fileExists = (entry) ->
      console.log "Using existing file for #{url} at #{entry.toInternalURL()}"
      deferred.resolve entry.toInternalURL()

    checkFilePresence = (fs) =>  
      fs.root.getFile 'jila/' + @filenameFor(url),
        create: false
      , fileExists
      , handleError

    window.requestFileSystem LocalFileSystem.PERSISTENT, 
                             0, 
                             checkFilePresence, 
                             handleError

    return deferred.promise

  store: (blob, url) =>
    deferred = @$q.defer()    
            
    handleError = () ->
      console.log "Error writing file for #{url}"
      deferred.reject()

    gotFileSystem = (fs) =>
      fs.root.getDirectory 'jila',
        create: true, 
      , gotDirectoryEntry
      , handleError

    gotDirectoryEntry = (dir) =>
      dir.setMetadata((->), handleError, { "com.apple.MobileBackup": 1});

      dir.getFile @filenameFor(url),
        create: true, 
      , gotFileEntry
      , handleError

    gotFileEntry = (entry) ->
      entry.createWriter (writer) ->
          writer.onwriteend = (e) ->
            console.log "Saving #{url} to #{entry.toInternalURL()}"
            deferred.resolve entry.toInternalURL()
          writer.onerror = handleError
            
          writer.write(blob)

    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, gotFileSystem, handleError

    return deferred.promise

angular.module('app').service 'fileService', ['$q', Service] if window.isWebView