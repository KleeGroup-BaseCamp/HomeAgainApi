mongo = require '../mongo'

exports.get = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body

    mongo.db.collection('users').findOne(
        {   
            user_id: req.params.user_id,
            api_key : req.params.api_key
            },
        (err, user) ->
                if(err) res.send(500);
                if(!user) res.send(403);
    );