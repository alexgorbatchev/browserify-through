through = require 'through'

module.exports = ({map, filter}) ->
  filter ?= -> true

  if map.length isnt 4
    originalMap = map
    map = (filepath, opts, data, callback) ->
      try
        callback null, originalMap filepath, opts, data
      catch e
        callback e

  (filepath, opts) ->
    data = ''

    write = (chunk) ->
      data += chunk

    end = ->
      map filepath, opts, data, (err, data) =>
        if err?
          @emit 'error', err
        else
          @queue data
          @queue null

    if filter filepath, opts
      through write, end
    else
      through()
