mongo = require '../models/connection'

###**
* @api {post} /user/login Login to HomeAgain
* @apiName PostUser
* @apiGroup User
* @apiExample Example usage:
*   curl -i \
*       -H "Content-Type: application/json" \
*       -d '{"username":"user", "password":"password"}' \
*       "http://homeagain.io/login"
* @apiParam {String}    id            <code>id</code> of the User.
* @apiParam {String}    password      Password of the User.
* @apiSuccess {String}  firstname     First Name of the User.
* @apiSuccess {String}  lastname      Last Name of the User.
* @apiSuccess {String}  id            <code>id</code> of the User.
* @apiSuccess {String}  api_key        APIkey that needs to be sent with each request with a star.
* @apiError             IdNotFound    The <code>id</code> of the User was not found.
* @apiError             WrongPassword The password is wrong.
* @apiSuccessExample Success-Response:
*     HTTP/1.1 200 OK
*     {
*       "firstname": "Matthieu",
*       "lastname": "Dupont"
*       "id": "23"
*       "api_key": "785876"
*     }
**###

###**
* @api {get} /user/:id Read data of a user*
* @apiName GetUser
* @apiGroup User
* @apiParam {String}    id            <code>id</code> of the User.
* @apiSuccess {String}  firstname     First Name of the User.
* @apiSuccess {String}  lastname      Last Name of the User.
* @apiSuccess {String}  id            <code>id</code> of the User.
* @apiErrorTitle (404)  404 Not Found
* @apiError (404)       IdNotFound    The <code>id</code> of the User was not found.
* @apiErrorTitle (401)  401 Unauthorized
* @apiError (401)       NoApikey      No apikey was sent with the request.
* @apiError (401)       NoAccessRight Wrong apikey.

**###


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
