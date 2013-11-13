express = require 'express'
{join} = require 'path'
{config} = require './config'
routes = require './routes'
backbone = require './routes/index'
collector = require './routes/collector'
sensor = require './routes/sensor'
room = require './routes/room'

# Init mongo connection only once
mongo = require './mongo'
mongo.init (error) ->
    if error
        throw error

app = express()
# Allow Cross Origin
app.use '/', (req, res, next) ->
    res.header("Access-Control-Allow-Origin", "*")
    res.header("Access-Control-Allow-Headers", "X-Requested-With")

    # TODO Non automatic content type
    next()

app.configure 'production', ->
    app.use express.limit '5mb'

app.configure ->
    app.set 'views', join __dirname, 'views'
    app.set 'view engine', config.view.engine
    app.use express.favicon()
    app.use express.logger 'dev'
    app.use express.bodyParser()
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
app.post '/collector/collect', collector.collect
app.get '/sensor/:sensor_id', sensor.get
app.get '/sensor', sensor.all
app.put('/sensor/:sensor_id', sensor.put)


app.get '/room/:room_id', room.get
app.get '/room', room.all


app.get '/test', routes.test('Mocha Tests')


### Default 404 middleware ###
app.use routes.error('Page not found :(', 404)

module.exports = exports = app
