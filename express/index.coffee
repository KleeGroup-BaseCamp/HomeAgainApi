express = require 'express'
{join} = require 'path'
{config} = require './config'
routes = require './routes'
backbone = require './routes/index'
collector = require './routes/collector'
sensor = require './routes/sensor'
room = require './routes/room'
login = require './routes/login'

# Init mongo connection only once
mongo = require './mongo'
mongo.initiate (db) ->
console.log('Connection to mongo')


app = express()
# Allow Cross Origin
app.use '/', (req, res, next) ->
    res.header("Access-Control-Allow-Origin", "*")
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    res.header("Access-Control-Allow-Headers", "Content-Type")

    # TODO Non automatic content type
    next()

loginMiddleware = (req, res, next) ->
    # Login middleware
    # add loginMiddleware as second argument for
    # endpoints that need login
    # user_id is int, api_key is string
    if !req.query.user_id or !req.query.api_key
        res.send 401
    else
        user_id = parseInt(req.query.user_id)
        api_key = req.query.api_key.toString()

        mongo.db.collection('homeagain_users').findOne(
            {
                user_id: user_id,
                api_key : api_key
            },
            (err, user) ->
                if err
                    res.send 500
                else if user
                    console.log("User " + user_id.toString() + " successfully logged in")
                    next()
                else
                    res.send 401
            )

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



app.all(/^\/admin.*$/, backbone.index)
app.post '/collector/collect', loginMiddleware, collector.collect
app.get '/sensor/:sensor_id', loginMiddleware, sensor.get
app.get '/sensor', loginMiddleware, sensor.all
app.put('/sensor/:sensor_id', loginMiddleware, sensor.put)


app.get '/room/:room_id', loginMiddleware, room.get
app.post '/room/', loginMiddleware, room.post
app.get '/room', loginMiddleware, loginMiddleware, room.all

app.post '/login', login.post

app.get '/test', routes.test('Mocha Tests')


### Default 404 middleware ###
app.use routes.error('Page not found :(', 404)

module.exports = exports = app

app.listen 4000
