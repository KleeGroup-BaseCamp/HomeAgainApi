models = require '../models/models'
BSON = require('mongodb').BSONPure;
async = require 'async'
exports.get = (req, res) ->
    if req.params.room_id
        models.Room.find({_id: BSON.ObjectID(req.params.room_id)}, (err, rooms) ->
            if err or ( rooms and rooms.length > 1 )
                res.send 500
            else if rooms and rooms.length > 0
                room = rooms[0]
                if !req.user.hubs or req.user.hubs.indexOf(room.hub) == -1
                    res.send 404
                
                criteria = 
                    room : room
                limit = 10

                models.Sensor.find(criteria).sort('-created_on').limit(limit).exec(
                    (err, sensors) ->
                        if err or sensors.length == 0
                            sensors = []
                        room.sensors = sensors
                        res.send JSON.stringify(room), 200
                )
        )
    else
        models.Room.find({hub : {$in : req.user.hubs }}, (err, rooms) ->
            if err
                res.send 500
            else 
                async.map(rooms,
                    (room, callback)->
                        # if !req.user.hubs or req.user.hubs.indexOf(room.hub_id) == -1
                        #     res.send 404
                        
                        criteria = 
                            room : room
                        limit = 10

                        models.Sensor.find(criteria).sort('-created_on').limit(limit).exec(
                            (err, sensors) ->
                                if err or sensors.length == 0
                                    sensors = []

                                room.sensors = sensors
                                callback(null, room)
                        )
                    ,
                    () ->
                        res.send rooms, 200
                    )
        )