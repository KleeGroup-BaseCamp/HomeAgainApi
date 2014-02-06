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
* @apiExample Example usage:
*     curl -i http://homeagain.io/sensors/23?api_key=8264823&datastart=1391631304&datastop=1391631800
* @apiParam {String}    id              <code>id</code> of the sensor.
* @apiParam {Date}    [datastart]       Beginning of the period you want to get data from.
* @apiParam {Date}    [dataend]         End of the period you want to get data from.
* @apiSuccess {String}  id              <code>id</code> of the sensor.
* @apiSuccess {String}  sensor          Name of the sensor.
* @apiSuccess {String}  room_id         Id of the room where the sensor is.
* @apiSuccess {String}  unit            Unit of the data given by the sensor.
* @apiSuccess {String}  data            By default, value and timestamp of the last data taken from the sensor. If a period is specified, list of all timestamp and data in this period.
* @apiError             IdNotFound      The <code>id</code> of the sensor was not found.
* @apiError             NoApikey        No apikey was sent with the request.
* @apiError             NoAccessRight   Wrong apikey.
* @apiError             WrongDatastart  datastart is at wrong format - should be a timestamp
* @apiError             WrongDatastop   datastop is at wrong format - should be a timestamp
* @apiError             NoDatastart     datastop was given with no datastart
* @apiError             NoDatastop      datastart was given with no datastop
* @apiSuccessExample Success-Response:
*     HTTP/1.1 200 OK
*     {
*       "id": "23",
*       "sensor": "Kitchen's temperature"
*       "room_id": "45"
*       "unit": "Temperature.Celsius"
*       "data": [{
*           "value": "23"
*           "timestamp": "1391631784"
*           }, ...
*           ]
*     }
**###


exports.get = (req, res) ->
    # If there is an ID, we send the sensor and its data
    if req.params.sensor_id
        mongo.db.collection('sensors').find({sensor_id: req.params.sensor_id}).toArray((err, sensors) ->
            # We only want one sensor, finding more indicate duplicate key in database
            
            if err or ( sensors and sensors.length > 1 )
                res.send 500
            else if sensors and sensors.length > 0 
                sensor = sensors[0]
                # We check that the user own the hub of this sensorr
                if !req.user.hubs or req.user.hubs.indexOf(sensor.hub_id) == -1
                    res.send 404
                responseObject = sensor
                criteria = 
                    sensor_id : sensor.sensor_id
                limit = 1 
                if req.query.datastart and req.query.dataend
                    criteria.created_on = 
                        $gte: parseInt(req.query.datastart)
                        $lt : parseInt(req.query.dataend)
                    console.log criteria
                    # TODO set dynamic limit
                    limit = 10
                
                mongo.db.collection('data').find(criteria).sort({created_on : -1}).limit(limit).toArray((err, data) -> 
                    
                    if err or data.length == 0
                        data = []
                    responseObject.data = data
                    res.send JSON.stringify(responseObject), 200
                )
            else # No sensors without error means that the sensor does not exist, send 404
                res.send 404
        )
    else 
        mongo.db.collection('sensors').find({hub_id : {$in : req.user.hubs }}).toArray((err, sensors) ->
            if err
                res.send 500
            else 
                res.send sensors, 200
        )


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

###exports.get = (req, res) ->
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
        )###

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
