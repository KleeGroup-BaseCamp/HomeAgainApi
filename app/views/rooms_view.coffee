View = require 'lib/view'
RoomView = require 'views/room_view'

module.exports = RoomsView = View.extend(
    initialize: ->
        this.collection.on('add', this.addOne, this)
        this.collection.on('reset', this.render, this)
    render: ->
        this.collection.models.forEach(this.addOne, this)
        
        $("#AppView").html(this.el)
        
        #this.collection.models.forEach(this.addOne, this)
        #this.collection.models.forEach(this.addOne, this)

    addOne: (model) ->
        roomView = new RoomView(model)
        roomView.model = model
        roomView.render()
        this.$el.append(roomView.el)
)
