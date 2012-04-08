'use strict';


// Declare app level module which depends on filters, and services
angular.module('myApp', ['myApp.filters', 'myApp.services', 'myApp.directives']).
  config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/mystuff', {template: 'partials/my-stuff.html', controller: MyStuffController});
    $routeProvider.when('/mystuff/:id', {template: 'partials/my-stuff-edit.html', controller: MyStuffEditController});
    $routeProvider.when('/friends', {template: 'partials/friends.html', controller: FriendsController});
    $routeProvider.when('/friends/:id', {template: 'partials/friend-edit.html', controller: FriendEditController});
    $routeProvider.when('/friends-stuff', {template: 'partials/friends-stuff.html', controller: FriendsStuffController});
    $routeProvider.when('/about', {template: 'partials/about.html', controller: AboutController});
    $routeProvider.otherwise({redirectTo: '/mystuff'});
  }]);
