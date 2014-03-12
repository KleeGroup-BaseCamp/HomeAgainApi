models = require('./express/models/models')

launchFixtures = (callback) ->

    # First we delete everything

    models.Hub.remove({}, (err) ->
        if err
            console.log('Error while emptying hubs')
        else
            models.Room.remove({}, (err) ->
                if err
                    console.log('Error while emptying rooms')
                else
                    models.DataModel.remove({}, (err) ->
                        if err
                            console.log('Error while emptying datamodels')
                        else
                            models.Data.remove({}, (err) ->
                                if err
                                    console.log('Error while emptying data')
                                else
                                    models.HomeagainUser.remove({}, (err) ->
                                        if err
                                            console.log('Error while emptying users')
                                        else
                                            models.HomeagainUser.remove({}, (err) ->
                                                if err
                                                    console.log('Error while emptying users')
                                                else
                                                    models.Sensor.remove({}, (err) ->
                                                        if err
                                                            console.log('Error while emptying sensors')
                                                        else
                                                            models.DataUnit.remove({}, (err) ->
                                                                if err
                                                                    console.log('Error while emptying data_units')
                                                                else
                                                                    console.log('Database emptied: filling it with sample data')
                                                                    addContentAfterEmpty()
                                                            )
                                                    )
                                            )
                                    )
                            )
                    )
            )
    )

    addContentAfterEmpty = () ->

      hub = new models.Hub(
          identifier: "HUB_1"
      )

      hub.save()

      user = new models.HomeagainUser(
          user_id : 1
          username : 'test'
          password : 'test'
          api_key : 'abcdef'
      )

      user.hubs.push(hub)

      user.save()

      kitchen = new models.Room(
          name: "Kitchen",
          hub: hub
      )

      kitchen.save()

      lroom = new models.Room(
          name: "Living Room",
          hub: hub
      )

      lroom.save()

      temperature = new models.DataModel(
          name: "temperature"
      )

      temperature.save()

      celsius = new models.DataUnit(
          name: "celsius",
          model: temperature
      )

      celsius.save()

      door = new models.DataModel(
          name: "door"
      )

      door.save()

      opened = new models.DataUnit(
          name: "opened",
          model: door
      )

      opened.save()

      moisture = new models.DataModel(
          name: "moisture"
      )

      moisture.save()

      perL = new models.DataUnit(
          name: "%perL",
          model: moisture
      )

      perL.save()

      presence = new models.DataModel(
        name: "presence"
      )

      presence.save()

      present = new models.DataUnit(
        name: "present",
        model: presence
      )

      present.save()

      PRESENCE_1 = new models.Sensor(
        identifier: "PRESENCE_1"
        model: presence
        hub: hub
        created_on: 1391638043046
        room: lroom
      )

      PRESENCE_1.save()

      PRESENCE_2 = new models.Sensor(
        identifier: "PRESENCE_2"
        model: presence
        hub: hub
        created_on: 1391638043046
        room: lroom
      )

      PRESENCE_2.save()

      PRESENCE_3 = new models.Sensor(
        identifier: "PRESENCE_3"
        model: presence
        hub: hub
        created_on: 1391638043046
        room: kitchen
      )

      PRESENCE_3.save()



      TEMP_1 = new models.Sensor(
          identifier: "TEMP_1"
          model: temperature
          hub: hub
          created_on: 1391638043046
          room: kitchen
      )

      TEMP_1.save()

      TEMP_3 = new models.Sensor(
          identifier: "TEMP_3"
          model: temperature
          hub: hub
          created_on: 1391638043052
          room: kitchen
      )

      TEMP_3.save()

      DOOR_1 = new models.Sensor(
          identifier: "DOOR_1"
          model: door
          hub: hub
          created_on: 1391638043058
          room: kitchen
      )

      DOOR_1.save()

      TEMP_2 = new models.Sensor(
          identifier: "TEMP_2"
          model: temperature
          hub: hub
          created_on: 1391638043059
          room: lroom
      )

      TEMP_2.save()

      DOOR_2 = new models.Sensor(
          identifier: "DOOR_2"
          model: door
          hub: hub
          created_on: 1391638043061
          room: kitchen
      )

      DOOR_2.save()

      DOOR_3 = new models.Sensor(
          identifier: "DOOR_3"
          model: door
          hub: hub
          created_on: 1391638043067
          room: lroom
      )

      DOOR_3.save()

      MOISTURE_1 = new models.Sensor(
          identifier: "MOISTURE_1"
          model: moisture
          hub: hub
          created_on: 1391638043068
          room: lroom
      )

      MOISTURE_1.save()

      MOISTURE_2 = new models.Sensor(
          identifier: "MOISTURE_2"
          model: moisture
          hub: hub
          created_on: 1391638043072
          room: lroom
      )

      MOISTURE_2.save()

      MOISTURE_3 = new models.Sensor(
          identifier: "MOISTURE_3"
          model: moisture
          hub: hub
          created_on: 1391638043073
          room: lroom
      )

      MOISTURE_3.save()


      data = [
        {
          sensor: TEMP_1
          value: 24.13
          model: temperature
          unit: celsius
          created_on: 1391637857267
        }
        {
          sensor: DOOR_2
          value: 0
          model: door
          unit: opened
          created_on: 1391637857272
        }
        {
          sensor: DOOR_1
          value: 1
          model: door
          unit: opened
          created_on: 1391637857272
        }
        {
          sensor: TEMP_2
          value: 22.68
          model: temperature
          unit: celsius
          created_on: 1391637857271
        }
        {
          sensor: DOOR_3
          value: 1
          model: door
          unit: opened
          created_on: 1391637857272
        }
        {
          sensor: MOISTURE_1
          value: 63.03
          model: moisture
          unit: perL
          created_on: 1391637857273
        }
        {
          sensor: MOISTURE_2
          value: 61.1
          model: moisture
          unit: perL
          created_on: 1391637857273
        }
        {
          sensor: MOISTURE_3
          value: 64.5
          model: moisture
          unit: perL
          created_on: 1391637857273
        }
        {
          sensor: TEMP_1
          value: 20.41
          model: temperature
          unit: celsius
          created_on: 1391637867274
        }
        {
          sensor: TEMP_2
          value: 21.38
          model: temperature
          unit: celsius
          created_on: 1391637867274
        }
        {
          sensor: TEMP_3
          value: 23.09
          model: temperature
          unit: celsius
          created_on: 1391637867275
        }
        {
          sensor: DOOR_1
          value: 1
          model: door
          unit: opened
          created_on: 1391637867275
        }
        {
          sensor: DOOR_2
          value: 1
          model: door
          unit: opened
          created_on: 1391637867275
        }
        {
          sensor: DOOR_3
          value: 0
          model: door
          unit: opened
          created_on: 1391637867275
        }
        {
          sensor: MOISTURE_1
          value: 62.15
          model: moisture
          unit: perL
          created_on: 1391637867275
        }
        {
          sensor: MOISTURE_2
          value: 62.91
          model: moisture
          unit: perL
          created_on: 1391637867275
        }
        {
          sensor: MOISTURE_3
          value: 60.66
          model: moisture
          unit: perL
          created_on: 1391637867276
        }
        {
          sensor: TEMP_1
          value: 20.8
          model: temperature
          unit: celsius
          created_on: 1391637877277
        }
        {
          sensor: TEMP_2
          value: 24.13
          model: temperature
          unit: celsius
          created_on: 1391637877277
        }
        {
          sensor: DOOR_2
          value: 0
          model: door
          unit: opened
          created_on: 1391637877279
        }
        {
          sensor: DOOR_1
          value: 1
          model: door
          unit: opened
          created_on: 1391637877278
        }
        {
          sensor: DOOR_3
          value: 1
          model: door
          unit: opened
          created_on: 1391637877280
        }
        {
          sensor: MOISTURE_1
          value: 64.99
          model: moisture
          unit: perL
          created_on: 1391637877280
        }
        {
          sensor: MOISTURE_2
          value: 63.16
          model: moisture
          unit: perL
          created_on: 1391637877280
        }
        {
          sensor: MOISTURE_3
          value: 61.98
          model: moisture
          unit: perL
          created_on: 1391637877280
        }
        {
          sensor: TEMP_1
          value: 21.43
          model: temperature
          unit: celsius
          created_on: 1391638043025
        }
        {
          sensor: TEMP_2
          value: 20.17
          model: temperature
          unit: celsius
          created_on: 1391638043030
        }
        {
          sensor: TEMP_3
          value: 23.84
          model: temperature
          unit: celsius
          created_on: 1391638043030
        }
        {
          sensor: DOOR_1
          value: 0
          model: door
          unit: opened
          created_on: 1391638043031
        }
        {
          sensor: DOOR_2
          value: 0
          model: door
          unit: opened
          created_on: 1391638043031
        }
        {
          sensor: DOOR_3
          value: 1
          model: door
          unit: opened
          created_on: 1391638043031
        }
        {
          sensor: MOISTURE_1
          value: 62.79
          model: moisture
          unit: perL
          created_on: 1391638043031
        }
        {
          sensor: MOISTURE_2
          value: 62.44
          model: moisture
          unit: perL
          created_on: 1391638043032
        }
        {
          sensor: MOISTURE_3
          value: 63.73
          model: moisture
          unit: perL
          created_on: 1391638043032
        }
        {
          sensor: TEMP_1
          value: 24.12
          model: temperature
          unit: celsius
          created_on: 1391638053033
        }
        {
          sensor: TEMP_2
          value: 22.81
          model: temperature
          unit: celsius
          created_on: 1391638053033
        }
        {
          sensor: TEMP_3
          value: 21.21
          model: temperature
          unit: celsius
          created_on: 1391638053033
        }
        {
          sensor: DOOR_1
          value: 0
          model: door
          unit: opened
          created_on: 1391638053033
        }
      ]



      # data.forEach(
      #     (dat) ->
      #         dataObject = new models.Data(
      #             sensor: dat.sensor,
      #             value: dat.value,
      #             model: dat.model,
      #             unit: dat.unit,
      #             created_on: dat.created_on
      #         )
      #         dataObject.save()
      # )
    callback()

if (require.main == module)
    # Fixtures called "by hand" from command line
    launchFixtures( ->
        console.log("Everything went well!")
        process.exit()
    )

exports.launchFixtures = launchFixtures
