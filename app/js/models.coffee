class Stuff
  constructor: (props)->
    @title = props?.title || ''
    @description = props?.description || ''
    time = new Date().getTime()
    @id = props?.id || ''+time
    @created = props?.created || time
    @modified = props?.modified || @created

  modify: ()->
    @modified = new Date().getTime()


class Friend
  constructor: (props)->
    @id = props?.id || ''+new Date().getTime()
    @name = props?.name || ''
    @userAddress = props?.userAddress || ''
    @secret = props?.secret || ''

# export
this.Stuff = Stuff
this.Friend = Friend