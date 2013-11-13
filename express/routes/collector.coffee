mongo = require '../mongo'

exports.collect = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body

    mongo.sensorCollection.count(
        {sensor_id : jsonData.sensor_id}, (err, count) ->
            if err
                console.log(err)
                res.send 500

            else if  count < 1
                console.log "Adding new sensor " + jsonData.sensor_id + " to DB"
                mongo.sensorCollection.insert(
                    {sensor_id : jsonData.sensor_id, model : jsonData.model }, {w:1}, (err, collection) ->
                        console.log(err)
                )
        )
    
    mongo.dataCollection.insert(
        jsonData, {w:1}, (err, collection) ->
            if err
                console.log(err)
                res.send 500
            else
                res.send 200
    )
