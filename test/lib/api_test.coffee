mongoose = require 'mongoose'
http = require 'http'
chai = require 'chai'
should = chai.should()

port = 4000
user_id = null
api_key = null

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

    it('should authenticate a user', (done) ->
        qstring = JSON.stringify({
            "username": "test",
            "password": "test"
        })
        options = defaultQueryOptions('/login', 'POST')
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

)
