mongo = require '../models/connection'
hat = require 'hat'

exports.post = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body

    if !jsonData.username or !jsonData.password
        res.send 400
    else
        apikey = hat()
        mongo.db.collection('homeagain_users').insert(
            {   
                username: jsonData.username,
                password : jsonData.password,
                api_key : apikey
                },
            (err, user) ->
                if err
                    if err.code
                        res.send JSON.stringify(
                            'mongo_error_code': err.code
                        ), 500
                    else
                        res.send 500
                else if user
                    user = user[0]
                    console.log("User successfully added")
                    res.send JSON.stringify(
                        'user_id': user._id
                        'api_key': user.api_key
                    ), 200
                else
                    res.send 401
        )
