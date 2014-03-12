mongoose = require 'mongoose'
http = require 'http'
chai = require 'chai'
should = chai.should()

port = 4000
user_id = null
api_key = null

addQSParm = (url, name, value) ->
    re = new RegExp("([?&]" + name + "=)[^&]+", "")

    add = (sep) ->
        url += sep + name + "=" + encodeURIComponent(value)

    change = () ->
        url = url.replace(re, "$1" + encodeURIComponent(value))

    if (url.indexOf("?") == -1)
        add("?")
    else
        if (re.test(url))
            change()
        else
            add("&")

    return url

defaultQueryOptions = (path, method) ->
    options = {
        "host": "localhost",
        "port": port,
        "path": path,
        "method": method,
        "headers": {
            "Content-type": "application/json"
        }
    }
    if user_id and api_key
        options.path = addQSParm(options.path, "user_id", user_id)
        options.path = addQSParm(options.path, "api_key", api_key)

    return options

describe('API Integration tests:', () ->
    before( (done) ->
        console.log('\nSetting up server')
        # Connecting mongoose to our mongo database

        mongoose.connect('mongodb://127.0.0.1:27017/homeagain_test', (error) ->
            # Loading fixtures in test database
            fixtures = require '../../fixtures'
            fixtures.launchFixtures( () ->
                require '../../express/index'
                done()
            )
        )

    )

    it('should be listening at localhost:4000', (done) ->
        headers = defaultQueryOptions('/', 'GET')
        http.get(headers, (res) ->
          res.statusCode.should.eql(404)
          done()
        )
    )

    it('should fail for an unlogged user', (done) ->
        options = defaultQueryOptions('/sensors/', 'GET')
        http.get(options, (res) ->
            res.statusCode.should.eql(401)
            done()
        )
    )

    it('should authenticate a user', (done) ->
        qstring = JSON.stringify({
            "username": "test",
            "password": "test"
        })
        options = defaultQueryOptions('/login/', 'POST')
        req = http.request(options)
        req.on('response', (res) ->
            res.on('data', (data) ->
                body = data.toString('utf8')
                body = JSON.parse(body)

                body.should.have.property('user_id')
                body.user_id.should.be.eql("5320b7e0dfe1cb7a340cca43")

                body.should.have.property('api_key')
                body.api_key.should.be.eql("abcdef")

                user_id = body.user_id
                api_key = body.api_key

                done()
            )
        )
        req.write(qstring)
        req.end()
    )

    it('should give list of sensors for a logged user', (done) ->
        options = defaultQueryOptions('/sensors/', 'GET')
        http.get(options, (res) ->
            res.statusCode.should.eql(200)
            res.on('data', (data) ->
                body = data.toString('utf8')
                body = JSON.parse(body)

                # Fixtures currently have size 12
                body.should.have.length(12)
                first_sensor = body[0]
                first_sensor.should.have.property('identifier')

                # In fixtures, first sensor is moisture_3
                first_sensor.identifier.should.be.eql('MOISTURE_3')

                first_sensor.should.have.property('model')
                first_sensor.should.have.property('hub')
                first_sensor.should.have.property('room')


            )
            done()
        )
    )

)
