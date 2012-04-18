'use strict';
/* App Controllers */


function AboutController($scope) {
    utils.log($scope.session);
    $scope.bla= "blase"
}
AboutController.$inject = ['$scope'];
