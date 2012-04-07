(function() {
  var MyStuffController, MyStuffEditController, focus, log;

  log = utils.log;

  focus = utils.focus;

  MyStuffController = function($scope, stuffDAO) {
    $scope.stuffList = [];
    $scope.isAddStuffFormHidden = true;
    stuffDAO.list(function(restoredStuffList) {
      $scope.stuffList = restoredStuffList;
      return $scope.isAddStuffFormHidden = $scope.stuffList.length > 0;
    });
    $scope.showAddForm = function() {
      $scope.isAddStuffFormHidden = false;
      return focus('title');
    };
    $scope.stuff = new Stuff();
    $scope.addStuff = function() {
      $scope.stuffList.push(new Stuff($scope.stuff));
      stuffDAO.save($scope.stuffList);
      $scope.stuff = new Stuff();
      $scope.isAddStuffFormHidden = true;
      return focus('showAddStuffFormButton');
    };
    return focus('showAddStuffFormButton');
  };

  MyStuffController.$inject = ['$scope', 'stuffDAO'];

  MyStuffEditController = function($scope, stuffDAO, $routeParams, $location) {
    $scope.stuff = new Stuff();
    stuffDAO.getItem($routeParams.id, function(stuff) {
      return $scope.stuff = stuff;
    });
    $scope.save = function() {
      stuffDAO.saveItem($scope.stuff);
      return $location.path('/mystuff');
    };
    return $scope["delete"] = function() {
      if (window.confirm("Do you really want to delete this stuff called \"" + $scope.stuff.title + "\"?")) {
        stuffDAO.deleteItem($scope.stuff.id);
        return $location.path('/mystuff');
      }
    };
  };

  MyStuffEditController.$inject = ['$scope', 'stuffDAO', '$routeParams', '$location'];

  this.MyStuffController = MyStuffController;

  this.MyStuffEditController = MyStuffEditController;

}).call(this);
