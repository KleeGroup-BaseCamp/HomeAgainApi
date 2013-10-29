mongo = require '../mongo'

exports.collect = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body
    mongo.dataCollection.insert(
        jsonData, {w:1}, (err, collection) ->
            console.log "Request terminated"
            if err
                console.log(err)
                res.send 500
            else
                res.send 200
    )
