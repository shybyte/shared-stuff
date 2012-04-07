class Stuff
  constructor: (props)->
    @title = props?.title || ''
    @description = props?.description || ''
    @id = ''+new Date().getTime()


this.Stuff = Stuff