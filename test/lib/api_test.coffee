mongoose = require 'mongoose'
http = require 'http'
chai = require 'chai'
should = chai.should()

port = 4000

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

describe('test the order of Mocha hooks', () ->
    before( () ->
        console.log('Setting up server')
        # Connecting mongoose to our mongo database

        mongoose.connect 'mongodb://127.0.0.1:27017/homeagain_test'

        # Loading fixtures in test database
        fixtures = require '../../fixtures'
        fixtures.launchFixtures( () ->
            console.log("Fixtures loaded")
            require '../../express/index'
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
            username: 'test',
            password: 'test'
        })
        options = defaultQueryOptions('/login', 'POST')
        req = http.request(options)
        req.on('response', (res) ->
            res.on('data', (data) ->
                body = data.toString('utf8')
                console.log(body)
            )
            # body = JSON.parse(d.toString('utf8'))
            # console.log(body)
            # # body.should.have.property('message').and.match(/logged in/)
            # # accountId = body.account.id
            # done()
        )
        req.write(qstring)
        req.end()
    )

)
