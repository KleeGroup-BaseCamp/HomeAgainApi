mongo = require('./express/models/connection')
BSON = require('mongodb').BSONPure;
async = require 'async'
user = {
    user_id : 1
    username : 'test'
    password : 'test'
    api_key : 'abcdef'
    hubs : [ "HUB_1"]
}


#################################################
#        SENSORS
#################################################
rooms = [
    {
        name : "Kitchen"
        hub_id : "HUB_1"
        _id : BSON.ObjectID("52f2d1d13c45222b74aa44a5")
    }
    {
        name : "Living room"
        hub_id : "HUB_1"
        _id : BSON.ObjectID("52f2d43e3c45222b74aa44a6")
    }
]

sensors = [
  {
    sensor_id: "TEMP_1"
    model: "temperature"
    hub_id: "HUB_1"
    created_on: 1391638043046
    _id: BSON.ObjectID("52f2b61b645834b3ca000002")
    room_id : "52f2d43e3c45222b74aa44a6"
  }
  {
    sensor_id: "TEMP_3"
    model: "temperature"
    hub_id: "HUB_1"
    created_on: 1391638043052
    _id: BSON.ObjectID("52f2b61b645834b3ca000007")
    room_id : "52f2d43e3c45222b74aa44a6"
  }
  {
    sensor_id: "DOOR_1"
    model: "door"
    hub_id: "HUB_1"
    created_on: 1391638043058
    _id: BSON.ObjectID("52f2b61b645834b3ca000008")
    room_id : "52f2d43e3c45222b74aa44a6"
  }
  {
    sensor_id: "TEMP_2"
    model: "temperature"
    hub_id: "HUB_1"
    created_on: 1391638043059
    _id: BSON.ObjectID("52f2b61b645834b3ca000009")
    room_id : "52f2d1d13c45222b74aa44a5"
  }
  {
    sensor_id: "DOOR_2"
    model: "door"
    hub_id: "HUB_1"
    created_on: 1391638043061
    _id: BSON.ObjectID("52f2b61b645834b3ca00000a")
    room_id : "52f2d43e3c45222b74aa44a6"
  }
  {
    sensor_id: "DOOR_3"
    model: "door"
    hub_id: "HUB_1"
    created_on: 1391638043067
    _id: BSON.ObjectID("52f2b61b645834b3ca00000d")
    room_id : "52f2d1d13c45222b74aa44a5"
  }
  {
    sensor_id: "MOISTURE_1"
    model: "moisture"
    hub_id: "HUB_1"
    created_on: 1391638043068
    _id: BSON.ObjectID("52f2b61b645834b3ca00000e")
    room_id : "52f2d1d13c45222b74aa44a5"
  }
  {
    sensor_id: "MOISTURE_2"
    model: "moisture"
    hub_id: "HUB_1"
    created_on: 1391638043072
    _id: BSON.ObjectID("52f2b61b645834b3ca000011")
    room_id : "52f2d1d13c45222b74aa44a5"
  }
  {
    sensor_id: "MOISTURE_3"
    model: "moisture"
    hub_id: "HUB_1"
    created_on: 1391638043073
    _id: BSON.ObjectID("52f2b61b645834b3ca000012")
    room_id : "52f2d1d13c45222b74aa44a5"
  }
]

#################################################
#        DATA
#################################################

data = [
  {
    sensor_id: "TEMP_1"
    value: "24.13"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391637857267
    _id: BSON.ObjectID("52f2b561cf65dbeac9000001")
  }
  {
    sensor_id: "DOOR_2"
    value: "0"
    model: "door"
    unit: "door.opened"
    created_on: 1391637857272
    _id: BSON.ObjectID("52f2b561cf65dbeac9000006")
  }
  {
    sensor_id: "DOOR_1"
    value: "1"
    model: "door"
    unit: "door.opened"
    created_on: 1391637857272
    _id: BSON.ObjectID("52f2b561cf65dbeac9000005")
  }
  {
    sensor_id: "TEMP_2"
    value: "22.68"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391637857271
    _id: BSON.ObjectID("52f2b561cf65dbeac9000004")
  }
  {
    sensor_id: "DOOR_3"
    value: "1"
    model: "door"
    unit: "door.opened"
    created_on: 1391637857272
    _id: BSON.ObjectID("52f2b561cf65dbeac900000a")
  }
  {
    sensor_id: "MOISTURE_1"
    value: "63.03"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637857273
    _id: BSON.ObjectID("52f2b561cf65dbeac900000b")
  }
  {
    sensor_id: "MOISTURE_2"
    value: "61.1"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637857273
    _id: BSON.ObjectID("52f2b561cf65dbeac900000c")
  }
  {
    sensor_id: "MOISTURE_3"
    value: "64.5"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637857273
    _id: BSON.ObjectID("52f2b561cf65dbeac9000011")
  }
  {
    sensor_id: "TEMP_1"
    value: "20.41"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391637867274
    _id: BSON.ObjectID("52f2b56bcf65dbeac9000013")
  }
  {
    sensor_id: "TEMP_2"
    value: "21.38"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391637867274
    _id: BSON.ObjectID("52f2b56bcf65dbeac9000014")
  }
  {
    sensor_id: "TEMP_3"
    value: "23.09"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391637867275
    _id: BSON.ObjectID("52f2b56bcf65dbeac9000015")
  }
  {
    sensor_id: "DOOR_1"
    value: "1"
    model: "door"
    unit: "door.opened"
    created_on: 1391637867275
    _id: BSON.ObjectID("52f2b56bcf65dbeac9000016")
  }
  {
    sensor_id: "DOOR_2"
    value: "1"
    model: "door"
    unit: "door.opened"
    created_on: 1391637867275
    _id: BSON.ObjectID("52f2b56bcf65dbeac9000017")
  }
  {
    sensor_id: "DOOR_3"
    value: "0"
    model: "door"
    unit: "door.opened"
    created_on: 1391637867275
    _id: BSON.ObjectID("52f2b56bcf65dbeac9000018")
  }
  {
    sensor_id: "MOISTURE_1"
    value: "62.15"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637867275
    _id: BSON.ObjectID("52f2b56bcf65dbeac9000019")
  }
  {
    sensor_id: "MOISTURE_2"
    value: "62.91"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637867275
    _id: BSON.ObjectID("52f2b56bcf65dbeac900001a")
  }
  {
    sensor_id: "MOISTURE_3"
    value: "60.66"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637867276
    _id: BSON.ObjectID("52f2b56bcf65dbeac900001b")
  }
  {
    sensor_id: "TEMP_1"
    value: "20.8"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391637877277
    _id: BSON.ObjectID("52f2b575cf65dbeac900001c")
  }
  {
    sensor_id: "TEMP_2"
    value: "24.13"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391637877277
    _id: BSON.ObjectID("52f2b575cf65dbeac900001d")
  }
  {
    sensor_id: "DOOR_2"
    value: "0"
    model: "door"
    unit: "door.opened"
    created_on: 1391637877279
    _id: BSON.ObjectID("52f2b575cf65dbeac900001f")
  }
  {
    sensor_id: "DOOR_1"
    value: "1"
    model: "door"
    unit: "door.opened"
    created_on: 1391637877278
    _id: BSON.ObjectID("52f2b575cf65dbeac9000020")
  }
  {
    sensor_id: "DOOR_3"
    value: "1"
    model: "door"
    unit: "door.opened"
    created_on: 1391637877280
    _id: BSON.ObjectID("52f2b575cf65dbeac9000021")
  }
  {
    sensor_id: "MOISTURE_1"
    value: "64.99"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637877280
    _id: BSON.ObjectID("52f2b575cf65dbeac9000022")
  }
  {
    sensor_id: "MOISTURE_2"
    value: "63.16"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637877280
    _id: BSON.ObjectID("52f2b575cf65dbeac9000023")
  }
  {
    sensor_id: "MOISTURE_3"
    value: "61.98"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391637877280
    _id: BSON.ObjectID("52f2b575cf65dbeac9000024")
  }
  {
    sensor_id: "TEMP_1"
    value: "21.43"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391638043025
    _id: BSON.ObjectID("52f2b61b645834b3ca000001")
  }
  {
    sensor_id: "TEMP_2"
    value: "20.17"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391638043030
    _id: BSON.ObjectID("52f2b61b645834b3ca000003")
  }
  {
    sensor_id: "TEMP_3"
    value: "23.84"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391638043030
    _id: BSON.ObjectID("52f2b61b645834b3ca000004")
  }
  {
    sensor_id: "DOOR_1"
    value: "0"
    model: "door"
    unit: "door.opened"
    created_on: 1391638043031
    _id: BSON.ObjectID("52f2b61b645834b3ca000005")
  }
  {
    sensor_id: "DOOR_2"
    value: "0"
    model: "door"
    unit: "door.opened"
    created_on: 1391638043031
    _id: BSON.ObjectID("52f2b61b645834b3ca000006")
  }
  {
    sensor_id: "DOOR_3"
    value: "1"
    model: "door"
    unit: "door.opened"
    created_on: 1391638043031
    _id: BSON.ObjectID("52f2b61b645834b3ca00000b")
  }
  {
    sensor_id: "MOISTURE_1"
    value: "62.79"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391638043031
    _id: BSON.ObjectID("52f2b61b645834b3ca00000c")
  }
  {
    sensor_id: "MOISTURE_2"
    value: "62.44"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391638043032
    _id: BSON.ObjectID("52f2b61b645834b3ca00000f")
  }
  {
    sensor_id: "MOISTURE_3"
    value: "63.73"
    model: "moisture"
    unit: "humidity.%perL"
    created_on: 1391638043032
    _id: BSON.ObjectID("52f2b61b645834b3ca000010")
  }
  {
    sensor_id: "TEMP_1"
    value: "24.12"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391638053033
    _id: BSON.ObjectID("52f2b625645834b3ca000013")
  }
  {
    sensor_id: "TEMP_2"
    value: "22.81"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391638053033
    _id: BSON.ObjectID("52f2b625645834b3ca000014")
  }
  {
    sensor_id: "TEMP_3"
    value: "21.21"
    model: "temperature"
    unit: "temperature.celsius"
    created_on: 1391638053033
    _id: BSON.ObjectID("52f2b625645834b3ca000015")
  }
  {
    sensor_id: "DOOR_1"
    value: "0"
    model: "door"
    unit: "door.opened"
    created_on: 1391638053033
    _id: BSON.ObjectID("52f2b625645834b3ca000016")
  }
]



mongo.initiate (db) ->
    # First drop everythin
    
    async.series([
        (callback) -> (
            if db.collection('homeagain_users')
                db.collection('homeagain_users').drop((err)->
                    if err
                        console.log "Error while dropping homeagain_users : " + err
                    else
                        console.log "Homeagain_users dropped"
                    callback(null, null)
                )
            else
                callback(null, null)
        ),
        (callback) -> (
            if db.collection('rooms')
                db.collection('rooms').drop((err)->
                    if err
                        console.log "Error while dropping rooms : " + err
                    else
                        console.log "Rooms dropped"
                    callback(null, null)
                )
            else
                callback(null, null)
        ),
        (callback) -> (
            if db.collection('sensors')
                db.collection('sensors').drop((err)->
                    if err
                        console.log "Error while dropping sensors : " + err
                    else
                        console.log "Sensors dropped"
                    callback(null, null)
                )
            else
                callback(null, null)
        ),
        (callback) -> (
            if db.collection('data') 
                db.collection('data').drop((err)->
                    if err
                        console.log "Error while dropping data : " + err
                    else
                        console.log "Data dropped"
                    callback(null, null)
                )
            else
                callback(null, null)
        )
        ],
        # Then rebuild the database
        ()->
            async.series([
                (callback) -> (
                    db.collection('homeagain_users').ensureIndex({"username":1}, {unique:true}, (err)->
                        if err
                            console.log "Error while creating ensuring homeagain_users index : " + err
                            process.exit(1)
                        else
                            console.log "Username index ensured"
                            callback(null, null)
                    )
                ),
                (callback) -> (
                    db.collection('rooms').insert(rooms, (err)->
                        if err
                            console.log "Error while creating rooms : " + err
                            process.exit(1)
                        else
                            console.log "Rooms created"
                            callback(null, null)
                    )
                ),
                (callback) -> (
                    db.collection('homeagain_users').insert(user, (err)->
                        if err
                            console.log "Error while creating user : " + err
                            process.exit(1)
                        else
                            console.log "User created"
                            callback(null, null)
                    )
                ),
                (callback) -> (
                    db.collection('sensors').insert(sensors, (err)->
                        if err
                            console.log "Error while creating sensors : " + err
                            process.exit(1)
                        else
                            console.log "Sensors created"
                            callback(null, null)
                    )
                ),
                (callback) -> (
                    db.collection('data').insert(data, (err)->
                        if err
                            console.log "Error while creating data : " + err
                            process.exit(1)
                        else
                            console.log "Data created"
                            callback(null, null)
                    )
                )
                ],
                # Last callback, everything went fine we exit 0.
                () ->
                    process.exit(0)
            )
        )
    

