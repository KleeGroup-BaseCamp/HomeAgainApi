mongoose = require 'mongoose'
http = require 'http'
chai = require 'chai'
should = chai.should()

defaultGetOptions = (path) ->
    options = {
        "host": "localhost",
        "port": 4000,
        "path": path,
        "method": "GET"
    }
    return options

describe('test the order of Mocha hooks', () ->
    before( () ->
        console.log('Setting up server')
        # Connecting mongoose to our mongo database

        mongoose.connect 'mongodb://127.0.0.1:27017/homeagain_test'

        # Loading fixtures in test database
        require '../../fixtures'

        # Run server

        describe('app', () ->
            before ((done) ->
                console.log('in before!')
            )
        )
        require '../../express/index'

    )
    it('should be listening at localhost:4000', (done) ->
        headers = defaultGetOptions('/')
        http.get(headers, (res) ->
          res.statusCode.should.eql(404)
          done()
        )
    )

)
