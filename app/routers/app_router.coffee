SensorModel = require('models/sensors-model')
AddSensorView = require('views/add_sensor_view')

module.exports = AppRouter = Backbone.Router.extend(
    routes:
        'admin/sensors/add': 'addSensor'
        'admin(/)': 'admin'
        "*path"  : "notFound"

    admin: ->
        console.log('This is admin page')
    addSensor: ->
        sensor = new SensorModel()
        form = new Backbone.Form({
            model: sensor
            })
        addSensorView = new AddSensorView()
        addSensorView.render()
        $("#form").html(form.render().$el)
        $("#submit").click( (object) ->
            form.commit()
            sensor.save()
            )
        #sensor.fetch()
        #sensor.save()  # Send data to server
    notFound: ->
        console.log('Not Found')
)
