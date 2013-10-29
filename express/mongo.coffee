mongodb = require 'mongodb'

module.exports.init = (callback) ->
    server = new mongodb.Server("127.0.0.1", 27017, {})
    new mongodb.Db('homeagain', server, {w:1}).open(
        (error, db) ->
            if error
                callback(error)
            else
                db.authenticate('homeagain', 'homeagain', (err, result) ->
                    if err
                        callback(err)
                    else
                        # If authentication worked, export db instance
                        module.exports.db = db
                        module.exports.dataCollection = new mongodb.Collection(
                            db, 'data'
                        )
                        module.exports.sensorCollection = new mongodb.Collection(
                            db, 'sensor'
                        )
                )
        )
