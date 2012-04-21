log = utils.log
focus = utils.focus
isBlank = utils.isBlank

FriendsController = ($scope,friendDAO,friendsStuffDAO)->
  $scope.friendList = []
  $scope.isAddFriendFormHidden = true

  friendDAO.list (restoredFriendList)->
    $scope.friendList = restoredFriendList
    $scope.isAddFriendFormHidden = $scope.friendList.length>0
    $scope.$digest();

  $scope.showAddForm = ()->
    $scope.isAddFriendFormHidden = false
    focus('name')

  $scope.friend = new Friend()

  $scope.addFriend = ()->
    $scope.friend.sanitize()
    friendsStuffDAO.validateFriend($scope.friend, (errors)->
      if errors.length==0
        $scope.friendList.push(new Friend($scope.friend))
        friendDAO.save($scope.friendList)
        $scope.friend = new Friend();
        $scope.isAddFriendFormHidden = true
        $scope.$digest();
        focus('showAddFriendFormButton')
      else
        $scope.showValidationErrors=true
        window.alert(errors.join(',')+" seems invalid")
    )

  focus('showAddFriendFormButton')


FriendsController.$inject = ['$scope','friendDAO','friendsStuffDAO']


FriendEditController = ($scope,friendDAO,friendsStuffDAO,$routeParams,$location)->
  $scope.friend = new Friend()
  $scope.editMode = false
  $scope.stuffList = []
  $scope.showValidationErrors=true

  friendDAO.getItem($routeParams.id,(friend)->
    $scope.friend = new Friend(friend)
    $scope.$digest()
    friendsStuffDAO.listStuffByFriend(friend, (friendStuff) ->
        $scope.stuffList = friendStuff
        $scope.$digest()
    )
  )

  redirectToList = ->
    $scope.$apply( ->
        $location.path('/friends')
    )

  $scope.save = ()->
    $scope.friend.sanitize()
    friendsStuffDAO.validateFriend($scope.friend, (errors)->
      if errors.length==0
        friendDAO.saveItem($scope.friend,redirectToList)
      else
        window.alert(errors.join(',')+" seems invalid")
    )


  $scope.showEditMode = ()->
    $scope.editMode = true

  $scope.delete = ()->
    if window.confirm("Do you really want to delete your friend \"#{$scope.friend.name}\"?")
      friendDAO.deleteItem($scope.friend.id,redirectToList)

FriendEditController.$inject = ['$scope','friendDAO','friendsStuffDAO','$routeParams','$location']


#export
this.FriendsController = FriendsController
this.FriendEditController = FriendEditController
