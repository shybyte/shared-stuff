log = utils.log
focus = utils.focus


AppController = ($scope)->
  $scope.session = {
      userAddress: localStorage.getItem('userAddress')
  }
  $scope.logout = ->
    remoteStorageUtils.deleteToken();
    window.location.replace('login.html')


AppController.$inject = ['$scope']


#export
this.AppController = AppController