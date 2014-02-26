models = require '../models/models'
hat = require 'hat'

exports.post = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body

    if !jsonData.username or !jsonData.password
        res.send 400
    else
        apikey = hat()
        newUser = new models.HomeagainUser(
            username: jsonData.username,
            password: jsonData.password,
            api_key: apikey
        )

        newUser.save((err, user) ->
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
