mongo = require '../models/connection'

exports.collect = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body

    mongo.db.collection('sensors').count(
        {sensor_id : jsonData.sensor_id}, (err, count) ->
            if err
                console.log(err)
                res.send 500

            else if  count < 1
                mongo.db.collection('sensors').insert(
                    {sensor_id : jsonData.sensor_id, model : jsonData.model, hub_id : jsonData.hub_id, created_on : Date.now()}, {w:1}, (err, collection) ->
                        console.log(err)
                )
        )
    data = 
        sensor_id : jsonData.sensor_id
        value : jsonData.value
        model : jsonData.model
        unit : jsonData.unit
        created_on : jsonData.created_on

    mongo.db.collection('data').insert(
        jsonData, {w:1}, (err, collection) ->
            if err
                console.log(err)
                res.send 500
            else
                res.send 200
    )
