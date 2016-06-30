noflo = require 'noflo'

log = (options, name, data) ->
  if options?
    console.log name, (util.inspect data,
      options.showHidden, options.depth, options.colors)
  else
    console.log name, data

exports.getComponent = ->
  c = new noflo.Component

  c.inPorts.add 'in',
    datatype: 'all'
    description: 'Packet to be printed through console.log'
  c.inPorts.add 'options',
    datatype: 'object'
    description: 'Options to be passed to console.log'
  c.inPorts.add 'name',
    datatype: 'string'
    description: 'name logger'
  c.outPorts.add 'out',
    datatype: 'all'

  noflo.helpers.WirePattern c,
    in: 'in'
    out: 'out'
    params: ['name']
    forwardGroups: true
    async: true
  , (data, groups, out, callback) ->
    log c.params.options, c.params.name, data
    out.send data
    do callback
