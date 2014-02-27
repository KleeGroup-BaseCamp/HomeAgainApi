models = require '../models/models'
BSON = require('mongodb').BSONPure;
async = require 'async'
ObjectId = require('mongoose').Types.ObjectId

exports.post = (req, res) ->
    roomData = req.body
    console.log req.user.hubs
    roomData.hub = req.user.hubs[0]
    console.log roomData
    room = new models.Room(roomData)
    
    room.save((err, data) ->
            if(err)
                res.json 500, err
            else
                res.json 200, data
        )

exports.get = (req, res) ->
    if req.params.room_id
        models.Room.find({_id: BSON.ObjectID(req.params.room_id)}, (err, rooms) ->
            if err or ( rooms and rooms.length > 1 )
                res.send 500
            else if rooms and rooms.length > 0
                roomObject = rooms[0].toObject()
                if !req.user.hubs or req.user.hubs.indexOf(roomObject.hub) == -1
                    res.send 404
                
                criteria = 
                    room : roomObject._id
                limit = 10

                models.Sensor.find(criteria).sort('-created_on').limit(limit).exec(
                    (err, sensors) ->
                        if err or sensors.length == 0
                            sensors = []
                        roomObject.sensors = sensors
                        res.json 200, roomObject
                )
        )
    else
        models.Room.find({hub : {$in : req.user.hubs }}, (err, rooms) ->
            if err
                res.send 500
            else 
                #async.map(rooms, (e, callback) -> callback(null, e.toObject(), (e, result, ) ))
                async.map(rooms,
                    (room, callback)->
                        console.log room
                        roomObject = room.toObject()
                        
                        criteria = 
                            room : new ObjectId(roomObject._id.toString())
                        limit = 10
                        
                        models.Sensor.find(criteria).sort('-created_on').limit(limit).populate('model').exec(
                            (err, sensors) ->
                                console.log sensors
                                if err or sensors.length == 0
                                    sensors = []
                                
                                roomObject.sensors = sensors
                                console.log roomObject
                                callback(null, roomObject)
                            )
                    ,
                    (err, result) ->
                        console.log result
                        res.json 200, result
                    )
        )