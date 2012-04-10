'use strict'
log = utils.log
focus = utils.focus


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
value('stuffDAO', new LocalStorageDAO('myStuffList')).
value('friendDAO', friendDAO).
value('friendsStuffDAO', new FriendsStuffDAO(friendDAO))
