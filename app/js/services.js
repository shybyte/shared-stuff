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
        getItem:function (id,callback) {
            var myStuffList = JSON.parse(localStorage.getItem('myStuffList') || '[]');
            callback(_.find(myStuffList,function(it) {return it.id==id}));
        },
        save:function (stuffList) {
            localStorage.setItem('myStuffList',JSON.stringify(stuffList))
        },
        saveItem:function (item) {
            var myStuffList = JSON.parse(localStorage.getItem('myStuffList') || '[]');
            var oldItem = _.find(myStuffList,function(it) {return it.id==item.id})
            myStuffList[_.indexOf(myStuffList,oldItem)] = item;
            localStorage.setItem('myStuffList',JSON.stringify(myStuffList))
        },
        deleteItem:function (id) {
            var myStuffList = JSON.parse(localStorage.getItem('myStuffList') || '[]');
            var oldItem = _.find(myStuffList,function(it) {return it.id==id})
            localStorage.setItem('myStuffList',JSON.stringify(_.without(myStuffList,oldItem)))
        }

    });


