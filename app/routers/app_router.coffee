SensorModel = require('models/sensors-model')
RoomModel = require('models/room-model')
SensorCollection = require('models/sensors-collection')

RoomCollection = require('models/room-collection')

SensorsView = require('views/sensors_view')
SensorView = require('views/sensor_view')
SensorEditView= require('views/sensor_edit')

RoomsView = require('views/rooms_view')
RoomAddView = require('views/room_add')

module.exports = AppRouter = Backbone.Router.extend(
    routes:
        'admin/sensors/': 'sensors'
        'admin/sensors/edit/:sensor_id': 'editSensor'
        'admin/rooms/': 'rooms'
        'admin/rooms/add/': 'addRoom'
        'admin(/)': 'admin'
        "*path"  : "notFound"

    admin: ->
        console.log('This is admin page')
    sensors: ->
        sensors = new SensorCollection()
        sensors.fetch(
            success: ->
                sensorsView = new SensorsView({collection: sensors})
                sensorsView.render()
        )

    editSensor: (sensor_id) ->
        sensor = new SensorModel()
        sensor.set({'sensor_id', sensor_id})
        sensor.fetch(
            success: ->
                sensorEdit = new SensorEditView()
                sensorEdit.model = sensor
                sensorEdit.render()
                $("#AppView").html(sensorEdit.$el)
                form = new Backbone.Form({
                    model: sensor
                    })
                $("#form").html(form.render().$el)
                $("#update").click( (object) ->
                    form.commit()
                    sensor.save(
                        null,
                        success: ->
                            console.log('Sensor successfully updated! ')
                            Backbone.history.navigate('/admin/sensors/', true)
                    )
                )
        )

    rooms: ->
        rooms = new RoomCollection()
        rooms.fetch(
            success: ->
                roomsView = new RoomsView({collection: rooms})
                roomsView.render()
        )

    addRoom: ->
        room = new RoomModel()
        form = new Backbone.Form({
            model: room
            })
        roomAddView = new RoomAddView()
        roomAddView.model = room
        roomAddView.render()
        $("#AppView").html(roomAddView.$el)
        $("#form").html(form.render().$el)
        $("#add").click( (object) ->
            form.commit()
            room.save(
                null,
                success: (model, response) ->
                    console.log('Room added successfully')
                    Backbone.history.navigate('/admin/rooms/', true)
                error: (model, response) ->
                    console.log(response)
            )
        )

    notFound: ->
        console.log('Not Found')
)
