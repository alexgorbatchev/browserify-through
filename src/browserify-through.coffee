through = require 'through'

module.exports = ({map, filter}) ->
  filter ?= -> true

  if map.length isnt 3
    originalMap = map
    map = (filepath, data, callback) ->
      try
        callback null, originalMap filepath, data
      catch e
        callback e

  (filepath) ->
    data = ''

    write = (chunk) ->
      data += chunk

    end = ->
      map filepath, data, (err, data) =>
        if err?
          @emit 'error', err
        else
          @queue data
          @queue null

    if filter filepath
      through write, end
    else
      through()
