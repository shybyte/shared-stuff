log = (t)->
  console.log(t)

focus = (id)->
  setTimeout(->
    $('#'+id).focus()
  ,100)

MyStuffController = ($scope,stuffDAO)->
  $scope.stuffList = []
  $scope.isAddStuffFormHidden = true

  stuffDAO.list (restoredStuffList)->
    $scope.stuffList = restoredStuffList
    $scope.isAddStuffFormHidden = $scope.stuffList.length>0

  $scope.showAddForm = ()->
    $scope.isAddStuffFormHidden = false
    focus('title')

  $scope.newStuff = {title: "", description: ""}

  $scope.addStuff = ()->
    $scope.newStuff.id = new Date().getTime();
    $scope.stuffList.push($scope.newStuff)
    stuffDAO.save($scope.stuffList)
    $scope.newStuff = {title: "", description: ""}
    $scope.isAddStuffFormHidden = true
    focus('showAddStuffFormButton')

  focus('showAddStuffFormButton')

MyStuffController.$inject = ['$scope','stuffDAO']

this.MyStuffController = MyStuffController
