mongoose = require 'mongoose'

# Connecting mongoose to our mongo database

mongoose.connect 'mongodb://127.0.0.1:27017/homeagain'
db = mongoose.connection

db.on('error', console.error.bind(console, 'connection error:'))
db.once('open', () -> 
    console.log('Connection to Homeagain mongo successful')
)

# Creating models: first a schema, then compile model

ObjectId = mongoose.Schema.ObjectId

HubSchema = mongoose.Schema(
    identifier: String
)

module.exports.Hub = mongoose.model('Hub', HubSchema)

RoomSchema = mongoose.Schema(
    name: String,
    hub: {
        type: mongoose.Schema.ObjectId,
        ref: 'HubSchema'
    }
)

module.exports.Room = mongoose.model('Room', RoomSchema)

DataModelSchema = mongoose.Schema(
    {name: String},
    {collection: "data_models"}
)

module.exports.DataModel = mongoose.model('DataModel', DataModelSchema)

DataUnitSchema = mongoose.Schema(
    {
        name: String,
        model: {
            type: mongoose.Schema.ObjectId,
            ref: 'DataModel'
        }
    }
    {
        collection: "data_units"
    }
)

module.exports.DataUnit = mongoose.model('DataUnit', DataUnitSchema)

DataSchema = mongoose.Schema(
    {
        sensor:  {
            type: mongoose.Schema.ObjectId,
            ref: 'Sensor'
        },
        value: Number,
        model: {
            type: mongoose.Schema.ObjectId,
            ref: 'DataModel'
        },
        unit: {
            type: mongoose.Schema.ObjectId,
            ref: 'DataUnit'
        },
        created_on: Date
    }
    {
        collection: "data"
    }
)

module.exports.Data = mongoose.model('Data', DataSchema)

HomeagainUserSchema = mongoose.Schema(
    {
        user_id: Number,
        username: String,
        password: String,
        api_key: String,
        hubs: [
            type: mongoose.Schema.ObjectId,
            ref: 'Hub'
        ]
    }
    {
        collection: "homeagain_users"
    }
)

module.exports.HomeagainUser = mongoose.model('HomeagainUser', HomeagainUserSchema)

SensorSchema = mongoose.Schema(
    identifier: String,
    name: String,
    model: {
        type: mongoose.Schema.ObjectId,
        ref: 'DataModel'
    },
    hub: {
        type: mongoose.Schema.ObjectId,
        ref: 'Hub'
    },
    created_on: Date,
    room: {
        type: mongoose.Schema.ObjectId,
        ref: 'Room'
    }
)

module.exports.Sensor = mongoose.model('Sensor', SensorSchema)