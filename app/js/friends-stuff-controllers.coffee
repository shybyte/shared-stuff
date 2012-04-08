log = utils.log
focus = utils.focus

FriendsStuffController = ($scope,$defer,friendDAO,friendsStuffDAO)->
  $scope.stuffList = []
  $scope.sortAttribute = '-modified'

  $defer ->
      friendsStuffDAO.list (stuffList)->
        $scope.stuffList = stuffList
        $scope.$digest();

  $scope.sortBy = (sortAttribute) ->
    log(sortAttribute)
    $scope.sortAttribute = sortAttribute


FriendsStuffController.$inject = ['$scope','$defer','friendDAO','friendsStuffDAO']

#export
this.FriendsStuffController = FriendsStuffController
