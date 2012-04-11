log = utils.log
rs = remoteStorageUtils

$ ->
  $('#loginForm').submit ->
    try
      remoteStorageID = $('#remoteStorageID').val()
      log(remoteStorageID)
      rs.connect(remoteStorageID, (error, storageInfo)->
          log(storageInfo)
      )
    catch e
      log(e)
    return false
