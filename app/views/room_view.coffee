View = require 'lib/view'

module.exports = RoomView = View.extend(
    className: "sensor"

    autoRender: off

    template: require 'views/templates/room_view'
)
