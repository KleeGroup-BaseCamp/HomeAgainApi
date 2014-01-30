mongo = require '../models/connection'
async = require 'async'


###**
* @api {get} /sensors Read the list of sensors*
* @apiName GetSensors
* @apiGroup Sensors
* @apiDescription This request gives the list of sensors of one user.
* @apiSuccess {String[]} id            List of <code>id</code> of the sensors that belong to one user.
* @apiError              NoApikey      No apikey was sent with the request.
* @apiError              NoAccessRight Wrong apikey.
**###

###**
* @api {get} /sensors/:id Read data of a sensor*
* @apiName GetSensorsId
* @apiGroup Sensors
* @apiDescription This request gives you information about a given sensor, for the user who is logged in.
* @apiParam {String}    id            <code>id</code> of the sensor.
* @apiParam {Date}    [datastart]     Beginning of the period you want to get data from.
* @apiParam {Date}    [dataend]       End of the period you want to get data from.
* @apiSuccess {String}  id            <code>id</code> of the sensor.
* @apiSuccess {String}  sensor        Name of the sensor.
* @apiSuccess {String}  room          Name of the room where the sensor is.
* @apiSuccess {String}  unit          Unit of the data given by the sensor.
* @apiSuccess {String}  data          By default, value of the last data taken from the sensor. If a period is specified, list of all data in this period.
* @apiSuccess {Date}    timestamp     By default, date when the last data was taken from the sensor. If a period is specified, list of all data the dated when a data was taken.
* @apiError             IdNotFound    The <code>id</code> of the sensor was not found.
* @apiError             NoApikey      No apikey was sent with the request.
* @apiError             NoAccessRight Wrong apikey.
**###



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
