'use strict'
###
    Module dependencies.
###
express = require 'express'
http = require('http')
{join} = require 'path'
{config} = require './config'

app = express()
server = http.createServer(app)
app.set('port', process.env.PORT || 4000)

mongo = require('./models/connection')
BSON = require('mongodb').BSONPure
###
    Require routes.
###
routes = require './routes'
backbone = require './routes/index'
collector = require './routes/collector'
sensor = require './routes/sensor'
rooms = require './routes/rooms'
login = require './routes/login'
signup = require './routes/signup'


# Allow Cross Origin middleware
app.use '/', (req, res, next) ->
    res.header("Access-Control-Allow-Origin", "*")
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    res.header("Access-Control-Allow-Headers", "Content-Type")

    # TODO Non automatic content type
    next()

###
    Define all the middleware use by the application.
    The order in which they are defined is important.
###
loginMiddleware = (req, res, next) ->
    # Login middleware
    # add loginMiddleware as second argument for
    # endpoints that need login
    # user_id is int, api_key is string
    if !req.query.user_id or !req.query.api_key
        res.send 401
    else
        user_id = req.query.user_id
        api_key = req.query.api_key.toString()
        # Mongo request should be in a model.
        console.log(user_id)
        mongo.db.collection('homeagain_users').findOne(
            {
                _id: BSON.ObjectID(user_id),
                api_key : api_key
            },
            (err, user) ->
                if err
                    res.send 500
                else if user
                    console.log("User " + user_id.toString() + " successfully logged in")
                    req.user = user
                    next()
                else
                    res.send 401
            )
### Default 404 middleware ###
# Seems to be buggy on my computer.
#app.use routes.error('Page not found :(', 404)

#Application name.
app.locals.title = "Home Again API"


# Init mongo connection only once
mongo.initiate (db) ->
    console.log('Connection is now established with mongoDB on homeAgain.')


###
    Configuration of the application.
###
app.configure 'production', ->
    app.use express.limit '5mb'

app.configure ->
    app.set 'views', join __dirname, 'views'
    app.set 'view engine', config.view.engine
    app.use express.favicon()
    app.use express.logger 'dev'
    app.use(express.json())
    app.use(express.urlencoded())
    app.use express.methodOverride()
    app.use express.compress()
    app.use express.cookieParser(config.cookie.secret)
    app.use express.session()
    #app.use express.csrf()
    app.use app.router
    app.use express.static join __dirname, '..', 'public'

app.configure 'development', ->
    app.use express.errorHandler()
    app.locals.pretty = true


###
    Actions
    TODO: put some controllers, which are called intp the index.coffee and register the routes.
    These controllers should also call model when accessing to mongodbd.
###
app.all(/^\/admin.*$/, backbone.index)
app.post '/collector/collect', collector.collect

###Sensor actions###

app.get '/sensors/:id', loginMiddleware, sensor.get
app.get '/sensors/', loginMiddleware, sensor.get
app.put('/sensors/:sensor_id', loginMiddleware, sensor.put)

###Room actions###
app.get '/rooms/:room_id', loginMiddleware, rooms.get
app.get '/rooms/', loginMiddleware, rooms.get

# Deprecated
#app.get '/room/:room_id', loginMiddleware, room.get
#app.post '/room/', loginMiddleware, room.post
#app.get '/room', loginMiddleware, room.all

app.post '/login', login.post
app.post '/signup', signup.post
app.get '/test', routes.test('Mocha Tests')

# Server launching
server.listen app.get('port'), ()->
    console.log('Express server listening on port', app.get('port'))

module.exports = exports = app
