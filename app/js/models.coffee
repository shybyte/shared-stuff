class Stuff
  constructor: (props)->
    @title = props?.title || ''
    @description = props?.description || ''
    @id = ''+new Date().getTime()


class Friend
  constructor: (props)->
    @name = props?.name || ''
    @stuffUrl = props?.stuffUrl || ''
    @id = ''+new Date().getTime()

# export
this.Stuff = Stuff
this.Friend = Friend