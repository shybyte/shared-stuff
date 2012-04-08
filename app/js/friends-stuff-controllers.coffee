log = utils.log
focus = utils.focus

FriendsStuffController = ($scope,$defer,friendDAO,friendsStuffDAO)->
  $scope.stuffList = []

  $defer ->
      friendsStuffDAO.list (stuffList)->
        $scope.stuffList = stuffList
        $scope.$digest();


FriendsStuffController.$inject = ['$scope','$defer','friendDAO','friendsStuffDAO']

#export
this.FriendsStuffController = FriendsStuffController
