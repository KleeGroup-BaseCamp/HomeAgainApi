SensorModel = require('models/sensors-model')

module.exports = AppRouter = Backbone.Router.extend(
    routes:
        'admin(/)': 'admin'
        "*path"  : "notFound"

    admin: ->
        console.log('hey')
        sensor = new SensorModel({sensor_id:"TEMP_1"})
        sensor.fetch()
        #sensor.save()  # Send data to server
    notFound: ->
        console.log('Not Found')
)
