mongo = require '../mongo'

###
**
* @api {get} /user/:id Request User information
* @apiName GetUser_test2
* @apiGroup User_test2
**
###

exports.collect = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body

    mongo.db.collection('sensor').count(
        {sensor_id : jsonData.sensor_id}, (err, count) ->
            if err
                console.log(err)
                res.send 500

            else if  count < 1
                console.log "Adding new sensor " + jsonData.sensor_id + " to DB"
                mongo.db.collection('sensor').insert(
                    {sensor_id : jsonData.sensor_id, model : jsonData.model }, {w:1}, (err, collection) ->
                        console.log(err)
                )
        )
    
    mongo.db.collection('data').insert(
        jsonData, {w:1}, (err, collection) ->
            if err
                console.log(err)
                res.send 500
            else
                res.send 200
    )
