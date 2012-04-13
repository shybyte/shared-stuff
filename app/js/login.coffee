log = utils.log
rs = remoteStorageUtils

$ ->
  $('#loginForm').submit ->
    try
      remoteStorageID = $('#remoteStorageID').val()
      log(remoteStorageID)
      rs.connect(remoteStorageID, (error, storageInfo)->
        rs.authorize(['public', 'sharedstuff'], (token) ->
          window.location.replace('index-dev.html')
        )
      )
    catch e
      log(e)
    return false
