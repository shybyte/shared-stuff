'use strict'

class LocalStorageDAO
  constructor: (@key) ->

  readAllItems: () -> JSON.parse(localStorage.getItem(@key) || '[]')
  findItemByID: (items,id) -> _.find(items,(it) -> it.id==id)

  list: (callback) ->
    callback(@readAllItems());

  getItem: (id,callback) ->
    callback(_.find(@readAllItems(),(it) -> it.id==id));

  save: (allItems) ->
    localStorage.setItem('myStuffList',JSON.stringify(allItems))

  saveItem: (item) ->
    items = @readAllItems()
    oldItem = @findItemByID(items,item.id)
    items[_.indexOf(items,oldItem)] = item;
    @save(items)

  deleteItem: (id) ->
    items = @readAllItems()
    oldItem = @findItemByID(items,id)
    @save(_.without(items,oldItem))



angular.module('myApp.services', []).
  value('version', '0.1').
  value('stuffDAO', new LocalStorageDAO('myStuffList')).
  value('friendsDAO', new LocalStorageDAO('myFriendsList'))
