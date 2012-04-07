(function() {
  var MyStuffController, focus, log;

  log = function(t) {
    return console.log(t);
  };

  focus = function(id) {
    return setTimeout(function() {
      return $('#' + id).focus();
    }, 100);
  };

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
    $scope.newStuff = {
      title: "",
      description: ""
    };
    $scope.addStuff = function() {
      $scope.newStuff.id = new Date().getTime();
      $scope.stuffList.push($scope.newStuff);
      stuffDAO.save($scope.stuffList);
      $scope.newStuff = {
        title: "",
        description: ""
      };
      $scope.isAddStuffFormHidden = true;
      return focus('showAddStuffFormButton');
    };
    return focus('showAddStuffFormButton');
  };

  MyStuffController.$inject = ['$scope', 'stuffDAO'];

  this.MyStuffController = MyStuffController;

}).call(this);
