noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component

  c.inPorts.add 'graphs',
    datatype: 'array'
    process: (event, payload) ->
      return unless event is 'data'
      c.outPorts.out.send
        graphLibrary: payload

  c.inPorts.add 'runtime',
    datatype: 'object'
    process: (event, payload) ->
      return unless event is 'data'
      c.outPorts.out.send
        clearGraphLibrary: true

  c.outPorts.add 'out',
    datatype: 'object'

  c
