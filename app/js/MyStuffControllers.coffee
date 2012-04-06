log = (t)->
  console.log(t)

focus = (id)->
  setTimeout(->
    $('#'+id).focus()
  ,100)


MyStuffController = ($scope)->
  $scope.stuffList = [
    {
    title: "Still",
    description: "This is a longer Description"
    },
    {
    title: "Domain Driven Design",
    description: "This is a longer Description"
    }
  ]

  $scope.isAddStuffFormHidden = true
  $scope.showAddForm = ()->
    $scope.isAddStuffFormHidden = false
    focus('title')

  $scope.newStuff = {title: "", description: ""}
  $scope.addStuff = ()->
    $scope.stuffList.push($scope.newStuff)
    $scope.newStuff = {title: "", description: ""}
    $scope.isAddStuffFormHidden = true
    focus('showAddStuffFormButton')

  focus('showAddStuffFormButton')

MyStuffController.$inject = ['$scope']

this.MyStuffController = MyStuffController
