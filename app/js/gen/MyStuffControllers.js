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

  MyStuffController = function($scope) {
    $scope.stuffList = [
      {
        title: "Still",
        description: "This is a longer Description"
      }, {
        title: "Domain Driven Design",
        description: "This is a longer Description"
      }
    ];
    $scope.isAddStuffFormHidden = true;
    $scope.showAddForm = function() {
      $scope.isAddStuffFormHidden = false;
      return focus('title');
    };
    $scope.newStuff = {
      title: "",
      description: ""
    };
    $scope.addStuff = function() {
      $scope.stuffList.push($scope.newStuff);
      $scope.newStuff = {
        title: "",
        description: ""
      };
      $scope.isAddStuffFormHidden = true;
      return focus('showAddStuffFormButton');
    };
    return focus('showAddStuffFormButton');
  };

  MyStuffController.$inject = ['$scope'];

  this.MyStuffController = MyStuffController;

}).call(this);
