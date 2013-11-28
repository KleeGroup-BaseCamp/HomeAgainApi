mongo = require('../mongo');
async = require('async');
BSON = require('mongodb').BSONPure;

exports.all = function(req, res){
    mongo.init();
    mongo.roomCollection.find().toArray(
        function(err, rooms){
            if(err) res.send(500);
            if(!rooms) res.send(404);
            async.map(rooms,
                function(room, callback){
                    #console.log("Looking for sensors with room_id : " + room._id);
                    mongo.sensorCollection.find({room_id : room._id.toString()}).toArray(
                        function(err, sensors){
                            room.sensors = sensors;
                            callback(null, room);
                        }
                    );

                },
                function (err, rooms){
                    if(err) res.send(500);

                    res.send(JSON.stringify(rooms), 200);
                }
            );

        }
    );
};

exports.get = function(req, res){
    #console.log(req.params.room_id);
    mongo.roomCollection.findOne(
        {_id : BSON.ObjectID(req.params.room_id)},
        function(err, room){
            if(err) res.send(500);
            if(!room) res.send(404);

            mongo.sensorCollection.find({room_id : room._id.toString()}).toArray(
                function(err, sensors){
                    #console.log("Query terminated");
                    #console.log(sensors);
                    room.sensors = sensors;
                    res.send(JSON.stringify(room), 200);
                }
            );
            
        }
    );
};

exports.post = function(req, res){
    mongo.roomCollection.insert(
        req.body,
        function(err, room){
            if(err) res.send(500);
            res.send(JSON.stringify(room), 200);
            
        }
    );
};
