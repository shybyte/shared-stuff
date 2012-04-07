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

  $scope.stuff = new Stuff()

  $scope.addStuff = ()->
    log($scope.stuff)
    ns = new Stuff($scope.stuff)
    log(ns)
    $scope.stuffList.push(new Stuff($scope.stuff))
    stuffDAO.save($scope.stuffList)
    $scope.stuff = new Stuff();
    $scope.isAddStuffFormHidden = true
    focus('showAddStuffFormButton')

  focus('showAddStuffFormButton')

MyStuffController.$inject = ['$scope','stuffDAO']


MyStuffEditController = ($scope,stuffDAO,$routeParams,$location)->
  $scope.stuff = new Stuff()

  stuffDAO.getItem($routeParams.id,(stuff)->
    $scope.stuff = stuff
  )

  $scope.save = ()->
    stuffDAO.saveItem($scope.stuff)
    $location.path('/mystuff');

  $scope.delete = ()->
    if window.confirm("Do you really want to delete this stuff called \"#{$scope.stuff.title}\"?")
      stuffDAO.deleteItem($scope.stuff.id)
      $location.path('/mystuff');

MyStuffEditController.$inject = ['$scope','stuffDAO','$routeParams','$location']


#export
this.MyStuffController = MyStuffController
this.MyStuffEditController = MyStuffEditController
