mongo = require '../mongo'

exports.post = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body

    if !jsonData.username or !jsonData.password
        res.send 400
    else
        mongo.db.collection('homeagain_users').findOne(
            {   
                username: jsonData.username,
                password : jsonData.password
                },
            (err, user) ->
                console.log(user)
                if err
                    res.send 500
                else if user
                    console.log("User successfully logged in")
                    res.send JSON.stringify({
                            'user_id': user.user_id,
                            'api_key': user.api_key
                        }), 200
                else
                    res.send 401
        )
