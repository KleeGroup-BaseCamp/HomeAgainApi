mongo = require '../mongo'
async = require 'async'

exports.lastData = (req, res) ->
#    if req.get('content-type').indexOf('application/json') == -1
#        throw new Error("Body request is not JSON.")

    mongo.dataCollection.findOne(
        {'sensor_id' : req.params.sensor_id},
        {timestamp: 1},
        (err, object) ->
            if err 
                res.send 500
            else
                res.send(JSON.stringify(object), 200)
        )
    
exports.all = (req, res) ->
    

#    if req.get('content-type').indexOf('application/json') == -1
#        throw new Error("Body request is not JSON.")


    mongo.sensorCollection.find().toArray((err, sensors) ->
            if err 
                res.send 500
            else
                #console.log(sensors)
                console.log("Ready to map the data")
                async.map(
                    sensors,
                    (sensor, callback) ->
                        console.log("Fetching last data")
                        console.log(sensor)
                        mongo.dataCollection.find({'sensor_id' : sensor.sensor_id}).sort({'timestamp': -1}).toArray(
                            (err, data) ->
                                if err 
                                    res.send 500
                                else
                                    sensor.lastData = data[0]
                                    console.log sensor
                                    callback null, sensor
                        )
                    (err, result) ->
                        if(err) 
                            res.send 500
                        res.send(JSON.stringify(result), 200)
                )
        )

exports.get = (req, res) ->
#    if req.get('content-type').indexOf('application/json') == -1
#        throw new Error("Body request is not JSON.")
    mongo.sensorCollection.findOne(
        {'sensor_id' : req.params.sensor_id},
        (err, sensor) ->
            if err 
                res.send 500
            else
                mongo.dataCollection.find({'sensor_id' : sensor.sensor_id}).sort({timestamp: -1}).toArray(
                    (err, data) ->
                        if err 
                            res.send 500
                        else
                            sensor.lastData = data[0]
                            res.send(JSON.stringify(sensor), 200)
                    )
        )
    

