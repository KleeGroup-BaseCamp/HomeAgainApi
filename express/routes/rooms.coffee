mongo = require '../models/connection'
BSON = require('mongodb').BSONPure;

exports.get = (req, res) ->
    if req.params.room_id
        mongo.db.collection('rooms').find({_id: BSON.ObjectID(req.params.room_id)}).toArray((err, rooms) ->
            if err or ( rooms and rooms.length > 1 )
                res.send 500
            else if rooms and rooms.length > 0
                room = rooms[0]
                if !req.user.hubs or req.user.hubs.indexOf(room.hub_id) == -1
                    res.send 404
                
                criteria = 
                    room_id : room._id.toString()
                limit = 10

                mongo.db.collection('sensors').find(criteria).sort({created_on : -1}).limit(limit).toArray((err, sensors) -> 
                    
                    if err or sensors.length == 0
                        sensors = []
                    room.sensors = sensors
                    res.send JSON.stringify(room), 200
                )
        )
    else
        mongo.db.collection('rooms').find({hub_id : {$in : req.user.hubs }}).toArray((err, rooms) ->
            if err
                res.send 500
            else 
                res.send rooms, 200
        )