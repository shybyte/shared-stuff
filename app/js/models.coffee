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
    @name = props?.name || ''
    @stuffUrl = props?.stuffUrl || ''
    @id = ''+new Date().getTime()

# export
this.Stuff = Stuff
this.Friend = Friend