View = require 'lib/view'

module.exports = SensorEdit = View.extend(
    className: "sensor"

    autoRender: off

    template: require 'views/templates/sensor_edit'
)
