require 'coffee-errors'

chai = require 'chai'
browserify = require 'browserify'
# using compiled JavaScript file here to be sure module works
browserifyThrough = require '../lib/browserify-through.js'

expect = chai.expect

describe 'browserify-through', ->
  test = (map) ->
    results = null

    before (done) ->
      b = browserify extensions: '.coffee'

      b.transform browserifyThrough
        map: map
        filter: (filepath) -> filepath.indexOf('not_processed') is -1

      b.add "#{__dirname}/fixtures/index.js"

      b.bundle (err, r) ->
        results = r
        done err

    it 'processes correct file', -> expect(results).to.match /hello fixed/
    it 'does not process', -> expect(results).to.match /hello not processed/

  describe 'map function with callback', ->
    test (filepath, data, callback) ->
      callback null, data.replace /processed/, 'fixed'

  describe 'map function which returns', ->
    test (filepath, data) ->
      data.replace /processed/, 'fixed'
