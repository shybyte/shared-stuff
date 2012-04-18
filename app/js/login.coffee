log = utils.log
rs = remoteStorageUtils

$ ->
  $('#loginForm').submit ->
    try
      remoteStorageID = $('#remoteStorageID').val()
      log(remoteStorageID)
      rs.connect(remoteStorageID, (error, storageInfo)->
        rs.authorize(['public', 'sharedstuff'], (token) ->
          localStorage.setItem('userAddress',remoteStorageID);
          window.location.replace('index-dev.html')
        )
      )
    catch e
      log(e)
    return false
