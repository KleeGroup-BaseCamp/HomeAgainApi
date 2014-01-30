mongodb = require 'mongodb'


module.exports.initiate = (callback) ->
    server = new mongodb.Server("127.0.0.1", 27017, {})
    mongoClient = mongodb.MongoClient.connect('mongodb://127.0.0.1:27017/homeagain', (err,db) ->
        if err
            throw err
        module.exports.db = db
        callback(db)
    )