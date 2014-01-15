mongo = require '../mongo'
async = require 'async'

exports.lastData = (req, res) ->
#    if req.get('content-type').indexOf('application/json') == -1
#        throw new Error("Body request is not JSON.")

    mongo.db.collection('data').findOne(
        {'sensor_id' : req.params.sensor_id},
        {timestamp: 1},
        (err, object) ->
            if err 
                res.send 500
            else if object
                if !object.user_id || !(object.user_id == req.user.user_id)
                    res.send 403
                else
                    res.send(JSON.stringify(object), 200)
            else 
                res.send 404
        )
    
exports.all = (req, res) ->
    mongo.db.collection('sensor').find({user_id: req.user.user_id}).toArray((err, sensors) ->
        if err 
            res.send 500
        else if sensors
            
            # Ready to map the data
            async.map(
                sensors,
                (sensor, callback) ->
                    # Fetching last data
                    #console.log(sensor)
                    mongo.db.collection('data').find({'sensor_id' : sensor.sensor_id}).sort({'timestamp': -1}).toArray(
                        (err, data) ->
                            if err 
                                res.send 500
                            else
                                sensor.data = data[0]
                                #console.log sensor
                                callback null, sensor
                    )
                (err, result) ->
                    if(err) 
                        res.send 500
                    res.send(JSON.stringify(result), 200)
            )
        else 
            res.send 404
    )

exports.get = (req, res) ->
    mongo.db.collection('sensor').findOne(
        {'sensor_id' : req.params.sensor_id},
        (err, sensor) ->
            if err 
                res.send 500
            else if sensor
                if !sensor.user_id || !(sensor.user_id == req.user.user_id)
                    res.send 403
                else
                    #console.log(sensor)
                    # Add the last data to the sensor
                    mongo.db.collection('data').find({'sensor_id' : sensor.sensor_id}).sort({timestamp: -1}).toArray(
                        (err, data) ->
                            if err 
                                res.send 500
                            else
                                sensor.data = data[0]
                                res.send(JSON.stringify(sensor), 200)
                        )
            else 
                res.send 404
        )

exports.put = (req, res) ->
    #console.log(req.params.sensor_id)
    delete req.body["_id"]
    mongo.db.collection('sensor').findOne(
        {'sensor_id' : req.params.sensor_id},
        (err, sensor) ->
            if err
                res.send 500
            else if sensor
                if !sensor.user_id || !(sensor.user_id == req.user.user_id)
                    res.send 403
                else
                    mongo.db.collection('sensor').update(
                        {'sensor_id' : req.params.sensor_id},
                        req.body,
                        {upsert: false},
                        (err, sensor) ->
                            if err
                                #console.log(err)
                                res.send 500
                            else
                                res.send(JSON.stringify(sensor), 200)
                    )
            else
                res.send 404
    )
