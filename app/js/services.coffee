'use strict'
log = utils.log
focus = utils.focus
doNothing = utils.doNothing
randomString = utils.randomString
defer= utils.defer

RS_CATEGORY = "sharedstuff"
MY_STUFF_KEY = "myStuffList"

rs = remoteStorageUtils

class RemoteStorageDAO
  constructor: (@category, @key) ->

  readAllItems: (callback) ->
    self = this
    if self.allItemsCache
      defer ->
        callback(self.allItemsCache)
    else
      rs.getItem(@category, @key, (error, data)->
          self.allItemsCache = JSON.parse(data || '[]')
          callback(self.allItemsCache)
      )

  findItemByID: (items, id) -> _.find(items, (it) -> it.id == id)

  list: (callback) ->
    @readAllItems(callback)

  getItem: (id, callback) ->
    @readAllItems (items) ->
      callback(_.find(items, (it) -> it.id == id))

  save: (allItems, callback) ->
    utils.cleanObjectFromAngular(allItems)
    rs.setItem(@category, @key, JSON.stringify(allItems), callback)

  saveItem: (item, callback) ->
    self = @
    @readAllItems (items) ->
      oldItem = self.findItemByID(items, item.id)
      if oldItem
        items[_.indexOf(items, oldItem)] = item
      else
        items.push(item)
      self.save(items, callback)

  deleteItem: (id, callback) ->
    self = @
    @readAllItems (items) ->
      oldItem = self.findItemByID(items, id)
      self.save(_.without(items, oldItem), callback)


class MyStuffDAO extends RemoteStorageDAO
  constructor: (@category, @key, @settingsDAO) ->

  save: (allItems, callback) ->
    super(allItems, callback)
    @settingsDAO.getSecret (secret)->
      rs.setItem('public', secret, JSON.stringify(allItems), doNothing)


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


MY_SECRET_KEY = "mySecret"
class SettingsDAO

  constructor: (@storageDAO) ->
  #

  getSecret: (callback) ->
    self = this
    @storageDAO.getItem(MY_SECRET_KEY, (secret)->
        if secret
          callback(secret.value)
        else
          secret = 'mystuff_' + randomString(20)
          self.storageDAO.saveItem({id: MY_SECRET_KEY, value: secret}, ()->
              callback(secret)
          )
    )


class FriendsStuffDAO
  constructor: (@friendDAO) ->
    @friendsStuffList = []

  listStuffByFriend: (friend, callback) ->
    if friend.userAddress
      remoteStorage.getStorageInfo(friend.userAddress, (error, storageInfo) ->
          client = remoteStorage.createClient(storageInfo, 'public')
          if storageInfo
            client.get(MY_STUFF_KEY, (err, data) ->
                if data
                  callback(JSON.parse(data || '[]'))
                else
                #log(err)
                  callback([])
            )
          else
            log(error)
      )

  list: (callback) ->
    self = @
    @friendDAO.list (friends)->
      for friend in friends
        bindUpdateToFriend = (friend)->
          return (friendStuff) ->
            self._updateWithLoadedItems(friend, friendStuff)
            callback(self.friendsStuffList)
        self.listStuffByFriend(friend, bindUpdateToFriend(friend))

  _updateWithLoadedItems: (friend, friendStuff)->
    for stuff in friendStuff
      stuff.owner = friend
      existingItem = _.find(@friendsStuffList, (it) -> it.id == stuff.id)
      if existingItem
        @friendsStuffList[_.indexOf(@friendsStuffList, existingItem)] = stuff
      else
        @friendsStuffList.push(stuff)


friendDAO = new RemoteStorageDAO(RS_CATEGORY, 'myFriendsList')
settingsDAO = new SettingsDAO(new RemoteStorageDAO(RS_CATEGORY, 'settings'))

angular.module('myApp.services', []).
value('version', '0.1').
value('settingsDAO', settingsDAO).
value('stuffDAO', new MyStuffDAO(RS_CATEGORY, MY_STUFF_KEY, settingsDAO)).
value('friendDAO', friendDAO).
value('friendsStuffDAO', new FriendsStuffDAO(friendDAO))
