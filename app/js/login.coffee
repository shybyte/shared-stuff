log = utils.log
rs = remoteStorageUtils

$ ->
  log(sessionStorage.getItem('targetHref'))
  $('#loginForm').submit ->
    try
      remoteStorageID = $('#remoteStorageID').val()
      log(remoteStorageID)
      rs.connect(remoteStorageID, (error, storageInfo)->
        rs.authorize(['public', 'sharedstuff'], (token) ->
          localStorage.setItem('userAddress',remoteStorageID);
          targetUrl = sessionStorage.getItem('targetHref') || 'index-dev.html';
          sessionStorage.removeItem('targetHref');
          window.location.replace(targetUrl)
        )
      )
    catch e
      log(e)
    return false
