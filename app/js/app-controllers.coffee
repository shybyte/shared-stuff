log = utils.log
focus = utils.focus


AppController = ($scope,settingsDAO)->
  $scope.session = {
      userAddress: localStorage.getItem('userAddress')
  }
  $scope.logout = ->
    remoteStorageUtils.deleteToken();
    window.location.replace('login.html')
  #settingsDAO.readSettings (settings)->
  #  $scope.session.settings = settings

AppController.$inject = ['$scope','settingsDAO']


#export
this.AppController = AppController