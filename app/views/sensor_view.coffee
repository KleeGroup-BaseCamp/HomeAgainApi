View = require 'lib/view'

module.exports = SensorView = View.extend(
    className: "sensor"

    autoRender: off

    template: require 'views/templates/sensor_view'
)
