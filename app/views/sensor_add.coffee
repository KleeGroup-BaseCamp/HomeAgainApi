View = require 'lib/view'

module.exports = SensorAdd = View.extend(
    className: "sensor"

    autoRender: off

    template: require 'views/templates/sensor_add'
)
