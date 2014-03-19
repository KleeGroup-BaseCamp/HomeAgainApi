models = require '../models/models'

###
@api {post} /login/ Login to HomeAgain
@apiName PostUser
@apiGroup User
@apiExample Example usage:
  curl -i \
      -H "Content-Type: application/json" \
      -d '{"username":"user", "password":"password"}' \
      "http://homeagain.io/login"
@apiParam {String}    username            <code>username</code> of the User.
@apiParam {String}    password      Password of the User.
@apiSuccess {String}  user_id            <code>user_id</code> of the User (ObjectId)
@apiSuccess {String}  api_key        APIkey that needs to be sent along with each request with a star.
@apiError             IdNotFound    The <code>id</code> of the User was not found.
@apiError             WrongPassword The password is wrong.
@apiSuccessExample Success-Response:
    HTTP/1.1 200 OK
    {
      "id": "23"
      "api_key": "785876"
    }
###

exports.post = (req, res) ->
    if req.get('content-type').indexOf('application/json') == -1
        throw new Error("Body request is not JSON.")

    jsonData = req.body
    if !jsonData.username or !jsonData.password
        res.send 400
    else
        models.HomeagainUser.findOne(
            {
                username: jsonData.username,
                password: jsonData.password
            },
            (err, user) ->
                if err
                    res.send 500
                else if user
                    console.log("User successfully logged in")
                    res.send JSON.stringify({
                        'user_id': user._id,
                        'api_key': user.api_key
                    }), 200
                else
                    res.send 401
        )
