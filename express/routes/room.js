mongo = require('../mongo');
async = require('async');
BSON = require('mongodb').BSONPure;


/**
* @api {get} /user/:id Request User information
* @apiName GetUser_test
* @apiGroup User_test
*/

exports.all = function(req, res){
    mongo.db.collection('room').find().toArray(
        function(err, rooms){
            if(err) res.send(500);
            if(!rooms) res.send(404);
            async.map(rooms,
                function(room, callback){
                    //console.log("Looking for sensors with room_id : " + room._id);
                    mongo.db.collection('sensor').find({room_id : room._id.toString()}).toArray(
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
    //console.log(req.params.room_id);
    mongo.db.collection('room').findOne(
        {_id : BSON.ObjectID(req.params.room_id)},
        function(err, room){
            if(err) res.send(500);
            if(!room) res.send(404);

            mongo.db.collection('sensor').find({room_id : room._id.toString()}).toArray(
                function(err, sensors){
                    //console.log("Query terminated");
                    //console.log(sensors);
                    room.sensors = sensors;
                    res.send(JSON.stringify(room), 200);
                }
            );
            
        }
    );
};

exports.post = function(req, res){
    mongo.db.collection('room').insert(
        req.body,
        function(err, room){
            if(err) res.send(500);
            res.send(JSON.stringify(room), 200);
            
        }
    );
};
