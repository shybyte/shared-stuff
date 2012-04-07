'use strict';


// Demonstrate how to register services
// In this case it is a simple constant service.
angular.module('myApp.services', []).
    value('version', '0.1').
    value('stuffDAO', {
        list:function (callback) {
            var myStuffList = JSON.parse(localStorage.getItem('myStuffList') || '[]');
            callback(myStuffList);
        },
        save:function (stuffList) {
            localStorage.setItem('myStuffList',JSON.stringify(stuffList))
        }
    });


