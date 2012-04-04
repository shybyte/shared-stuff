(function() {
  var MyStuffController;

  MyStuffController = function($scope) {
    return $scope.stuffList = [
      {
        title: "Still",
        description: "This is a longer Description"
      }, {
        title: "Domain Driven Design",
        description: "This is a longer Description"
      }
    ];
  };

  MyStuffController.$inject = ['$scope'];

  this.MyStuffController = MyStuffController;

}).call(this);
