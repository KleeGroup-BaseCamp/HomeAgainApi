View = require 'lib/view'
SensorView = require 'views/sensor_view'

module.exports = SensorsView = View.extend(
    initialize: ->
        this.collection.on('add', this.addOne, this)
        this.collection.on('reset', this.render, this)
    render: ->
        this.collection.models.forEach(this.addOne, this)
        $("#AppView").html(this.el)
        #this.collection.models.forEach(this.addOne, this)
        #this.collection.models.forEach(this.addOne, this)
    addOne: (model) ->
        sensorView = new SensorView(model)
        sensorView.model = model
        sensorView.render()
        this.$el.append(sensorView.el)
)
