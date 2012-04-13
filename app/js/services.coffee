'use strict'
log = utils.log
focus = utils.focus


rs = remoteStorageUtils

class RemoteStorageDAO
  constructor: (@category,@key) ->

  readAllItems: (callback) ->
    rs.getItem(@category,@key, (error,data)->
      callback(JSON.parse(data || '[]'))
    )

  findItemByID: (items, id) -> _.find(items, (it) -> it.id == id)

  list: (callback) ->
    @readAllItems(callback)

  getItem: (id, callback) ->
    @readAllItems (items) ->
      callback(_.find(items, (it) -> it.id == id))

  save: (allItems,callback) ->
    utils.cleanObjectFromAngular(allItems)
    rs.setItem(@category,@key, JSON.stringify(allItems), callback)

  saveItem: (item,callback) ->
    self = @
    @readAllItems (items) ->
      oldItem = self.findItemByID(items, item.id)
      items[_.indexOf(items, oldItem)] = item
      self.save(items,callback)

  deleteItem: (id,callback) ->
    self = @
    @readAllItems (items) ->
      oldItem = self.findItemByID(items, id)
      self.save(_.without(items, oldItem),callback)


class LocalStorageDAO
  constructor: (@key) ->

  readAllItems: () -> JSON.parse(localStorage.getItem(@key) || '[]')
  findItemByID: (items, id) -> _.find(items, (it) -> it.id == id)

  list: (callback) ->
    callback(@readAllItems())

  getItem: (id, callback) ->
    callback(_.find(@readAllItems(), (it) -> it.id == id))

  save: (allItems) ->
    utils.cleanObjectFromAngular(allItems)
    localStorage.setItem(@key, JSON.stringify(allItems))

  saveItem: (item) ->
    items = @readAllItems()
    oldItem = @findItemByID(items, item.id)
    items[_.indexOf(items, oldItem)] = item
    @save(items)

  deleteItem: (id) ->
    items = @readAllItems()
    oldItem = @findItemByID(items, id)
    @save(_.without(items, oldItem))


class FriendsStuffDAO
  constructor: (@friendDAO) ->
    @friendsStuffList = []

  listStuffByFriend: (friend,callback) ->
    $.ajax({ url: friend.stuffUrl, success: (friendStuff) ->
      for stuff in friendStuff
        stuff.owner = friend
      callback(friendStuff)
    })

  list: (callback) ->
    self = @
    @friendDAO.list (friends)->
      for friend in friends
        bindUpdateToFriend = (friend)->
          (friendStuff) ->
            self._updateWithLoadedItems(friend, friendStuff)
            callback(self.friendsStuffList)
        $.ajax({ url: friend.stuffUrl, success: bindUpdateToFriend(friend)})

  _updateWithLoadedItems: (friend, friendStuff)->
    for stuff in friendStuff
      stuff.owner = friend
      existingItem = _.find(@friendsStuffList, (it) -> it.id == stuff.id)
      if existingItem
        @friendsStuffList[_.indexOf(@friendsStuffList, existingItem)] = stuff
      else
        @friendsStuffList.push(stuff)


friendDAO = new LocalStorageDAO('myFriendsList')
;

angular.module('myApp.services', []).
value('version', '0.1').
value('stuffDAO', new RemoteStorageDAO('sharedstuff','myStuffList')).
value('friendDAO', friendDAO).
value('friendsStuffDAO', new FriendsStuffDAO(friendDAO))
