log = utils.log
focus = utils.focus


AppController = ($scope)->
  $scope.session = {
      userAddress: localStorage.getItem('userAddress')
  }


AppController.$inject = ['$scope']


#export
this.AppController = AppController