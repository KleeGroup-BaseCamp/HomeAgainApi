mongodb = require 'mongodb'

module.exports.initiate = (callback) ->
    server = new mongodb.Server("127.0.0.1", 27017, {})
    mongoClient = mongodb.MongoClient.connect('mongodb://127.0.0.1:27017/homeagain', (err,db) ->
        if err
            throw err
        module.exports.db = db
        callback(db)
    )
    # global.mongoConnection = global.mongoConnection || new mongodb.Db('homeagain', server, {w:1}).open(
    #     (error, db) ->
    #         if error
    #             callback(error)
    #         else
    #             db.authenticate('homeagain', 'homeagain', (err, result) ->
    #                 if err
    #                     callback(err)
    #                 else
    #                     #console.log result
    #                     # If authentication worked, export db instance
    #                     module.exports.db = db
    #                     dataCollection = dataCollection || new mongodb.Collection(
    #                         db, 'data'
    #                     )
    #                     module.exports.dataCollection = dataCollection

    #                     sensorCollection = sensorCollection || new mongodb.Collection(
    #                         db, 'sensor'
    #                     )
    #                     module.exports.sensorCollection = sensorCollection

    #                     roomCollection = roomCollection || new mongodb.Collection(
    #                         db, 'room'
    #                     )
    #                     module.exports.roomCollection = roomCollection
    #             )
    #     )
