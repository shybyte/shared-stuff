'use strict';


// Declare app level module which depends on filters, and services
angular.module('myApp', ['myApp.filters', 'myApp.services', 'myApp.directives']).
  config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/mystuff', {template: 'partials/MyStuff.html', controller: MyStuffController});
    $routeProvider.when('/mystuff/:id', {template: 'partials/MyStuffEdit.html', controller: MyStuffEditController});
    $routeProvider.when('/friendsstuff', {template: 'partials/partial2.html', controller: MyCtrl2});
    $routeProvider.when('/friends', {template: 'partials/friends.html', controller: FriendsController});
    $routeProvider.when('/friends/:id', {template: 'partials/friend-edit.html', controller: FriendEditController});
    $routeProvider.otherwise({redirectTo: '/mystuff'});
  }]);
