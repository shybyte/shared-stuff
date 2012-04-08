log = utils.log
focus = utils.focus


FriendsController = ($scope,friendDAO)->
  $scope.friendList = []
  $scope.isAddFriendFormHidden = true

  friendDAO.list (restoredFriendList)->
    $scope.friendList = restoredFriendList
    $scope.isAddFriendFormHidden = $scope.friendList.length>0

  $scope.showAddForm = ()->
    $scope.isAddFriendFormHidden = false
    focus('name')

  $scope.friend = new Friend()

  $scope.addFriend = ()->
    $scope.friendList.push(new Friend($scope.friend))
    friendDAO.save($scope.friendList)
    $scope.friend = new Friend();
    $scope.isAddFriendFormHidden = true
    focus('showAddFriendFormButton')

  focus('showAddFriendFormButton')

FriendsController.$inject = ['$scope','friendDAO']


FriendEditController = ($scope,friendDAO,friendsStuffDAO,$routeParams,$location)->
  $scope.friend = new Friend()
  $scope.editMode = false
  $scope.stuffList = []


  friendDAO.getItem($routeParams.id,(friend)->
    $scope.friend = friend
    friendsStuffDAO.listStuffByFriend(friend, (friendStuff) ->
        $scope.stuffList = friendStuff
        $scope.$digest()
    )
  )

  $scope.save = ()->
    friendDAO.saveItem($scope.friend)
    $location.path('/friends');

  $scope.showEditMode = ()->
    $scope.editMode = true

  $scope.delete = ()->
    if window.confirm("Do you really want to delete your friend \"#{$scope.friend.name}\"?")
      friendDAO.deleteItem($scope.friend.id)
      $location.path('/friends');

FriendEditController.$inject = ['$scope','friendDAO','friendsStuffDAO','$routeParams','$location']


#export
this.FriendsController = FriendsController
this.FriendEditController = FriendEditController
