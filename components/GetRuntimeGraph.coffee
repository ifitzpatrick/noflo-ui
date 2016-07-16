noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.inPorts.add 'context',
    datatype: 'object'
  c.outPorts.add 'context',
    datatype: 'object'
  c.outPorts.add 'error',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    in: 'context'
    out: 'context'
  , (data, groups, out) ->
    unless data.runtime
      return c.error new Error 'No runtime available'
    unless data.runtime.definition
      return c.error new Error 'Runtime has no definition available'

    data.remote = [] unless data.remote
    data.graphs = [] unless data.graphs

    if data.runtime.definition.graph
      if data.remote.indexOf(data.runtime.definition.graph) is -1
        data.remote.unshift data.runtime.definition.graph
      out.send data
      return

    # No graph available, prepare empty
    data.state = 'ok'
    unless data.graphs.length or data.remote.length
      emptyGraph = new noflo.Graph data.runtime.definition.id, caseSensitive: true
      emptyGraph.properties.id = data.runtime.definition.id
      data.graphs.unshift emptyGraph
      data.remote.unshift emptyGraph.properties.id
    out.send data

  c
