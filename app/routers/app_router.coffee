SensorCollection = require('models/sensors-collection')
SensorModel = require('models/sensors-model')
AddSensorView = require('views/add_sensor_view')
SensorsView = require('views/sensors_view')
SensorView = require('views/sensor_view')
SensorEdit = require('views/sensor_edit')

module.exports = AppRouter = Backbone.Router.extend(
    routes:
        'admin/sensors/': 'sensors'
        'admin/sensors/edit/:sensor_id': 'editSensor'
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
                sensorEdit = new SensorEdit()
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
                            console.log('successfully updated! ')
                            Backbone.history.navigate('/admin/sensors/', true)
                    )
                )
        )

    notFound: ->
        console.log('Not Found')
)
