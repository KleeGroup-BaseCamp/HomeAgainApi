View = require 'lib/view'

module.exports = AddSensorView = View.extend(
    el: '#AppView'

    name: 'AddSensorView'

    template: require 'views/templates/add_sensor_view'

    bootstrap: ->
        console.log "#{@name} bootstrap..."
)

# *** Note, lib/view doesn't execute bootstrap anymore ***
# *** You now have to override initialize and add it   ***
AddSensorView::initialize = ->
    @bootstrap()
    super

# Alternatively, you could listen for the initialize
# or initialize:before events and put your logic there
AddSensorView::on 'initialize', ->
    console.log "#{@name} initialized..."

