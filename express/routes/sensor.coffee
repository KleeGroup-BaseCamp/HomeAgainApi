models = require '../models/models'
async = require 'async'
ObjectId = require('mongoose').Types.ObjectId

###
@api {get} /sensors/ Read the list of sensors*
@apiName GetSensors
@apiGroup Sensors
@apiDescription This request gives the list of sensors of the user.
@apiSuccess {Sensor[]}  (No-Name)          List of <code>sensors</code>, see <code>/sensors/:id</code> for a detailed structure.
@apiError              NoApikey      No apikey was sent with the request.
@apiError              NoAccessRight Wrong apikey.
###

###
@api {get} /sensors/:identifier Read data of a sensor*
@apiName GetSensorsId
@apiGroup Sensors
@apiDescription This request gives you information about a given sensor, for the user who is logged in.
@apiExample Example usage:
    curl -i http://homeagain.io/sensors/23?api_key=8264823&datastart=1391631304&datastop=1391631800
@apiParam {String}    identifier              <code>identifier</code> of the sensor.
@apiParam {Date}    [datastart]       Beginning of the period you want to get data from.
@apiParam {Date}    [dataend]         End of the period you want to get data from.
@apiSuccess {String}  identifier              <code>id</code> of the sensor.
@apiSuccess {String}  name          Name of the sensor.
@apiSuccess {Type}  model         Model used for the sensor (with a <code>name</code> argument)
@apiSuccess {Id}  hub            ObjectId of the Hub to which this sensor is linked
@apiSuccess {Date}  created_on       Date the sensor was created on
@apiSuccess {Id}  room       ObjectId of the room the sensor is assigned to

@apiError             IdNotFound      The <code>id</code> of the sensor was not found.
@apiError             NoApikey        No apikey was sent with the request.
@apiError             NoAccessRight   Wrong apikey.
@apiError             WrongDatastart  datastart is at wrong format - should be a timestamp
@apiError             WrongDatastop   datastop is at wrong format - should be a timestamp
@apiError             NoDatastart     datastop was given with no datastart
@apiError             NoDatastop      datastart was given with no datastop
@apiSuccessExample Success-Response:
    HTTP/1.1 200 OK
    {
        "identifier": "MOISTURE_3",
        "model": {
            "name": "moisture",
            "_id": "5329b7fcb5cc66dd9d79c2f9",
            "__v": 0
        },
        "hub": "5329b7fcb5cc66dd9d79c2f2",
        "created_on": "2014-02-05T22:07:23.073Z",
        "room": "5329b7fcb5cc66dd9d79c2f4",
        "_id": "5329b7fcb5cc66dd9d79c308",
        "__v": 0,
        "data": []
    }
###



exports.put = (req, res) ->
    sensorData =
        name : req.body.name
        room : new ObjectId(req.body.room)
    console.log sensorData
    console.log req.body

    models.Sensor.update({ _id : req.body._id }, { $set : sensorData }, {}, (err, nb)->
        console.log "Affected : " + nb
        if(err)
            res.json 500, err
        else
            res.json {}, 200
    )


exports.get = (req, res) ->
    # If there is an ID, we send the sensor and its data
    if req.params.sensor_id
        console.log req.params.sensor_id
        models.Sensor.find({identifier: req.params.sensor_id}).populate('model').sort('-_id').exec((err, sensors) ->
            # We only want one sensor, finding more indicate duplicate key in database
            if err or ( sensors and sensors.length > 1 )
                res.send 500
            else if sensors and sensors.length > 0
                sensor = sensors[0]
                # We check that the user own the hub of this sensorr
                #if !req.user.hubs or req.user.hubs.indexOf(sensor.hub_id) == -1
                #    res.send 404

                responseSensor = sensor.toObject()
                criteria =
                    sensor : new ObjectId(sensor._id.toString())
                limit = 1
                if req.query.datastart and req.query.dataend
                    criteria.created_on =
                        $gte: parseInt(req.query.datastart)
                        $lt : parseInt(req.query.dataend)
                    limit = 10

                models.Data.find(criteria).sort('-_id').limit(limit).populate('unit').populate('model').exec((err, data) ->

                    if err or data.length == 0
                        data = []

                    responseSensor.data = data
                    res.json 200, responseSensor)

            else # No sensors without error means that the sensor does not exist, send 404
                res.send 404
        )
    else
        models.Sensor.find({hub: {$in: req.user.hubs}}).sort('-_id').populate('model').exec((err, sensors) ->
            if err
                res.send 500
            else
                res.send sensors, 200
        )

