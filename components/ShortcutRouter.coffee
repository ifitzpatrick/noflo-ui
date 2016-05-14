noflo = require 'noflo'

class ShortcutRouter extends noflo.Component
  routes: null
  currentRoute: null
  key: null

  constructor: ->
    super

    @routes = []

    @inPorts.add 'routes',
      datatype: 'string',
      description: 'add a route where shortcut is allowed to activate'
    , (event, payload) =>
      if event is 'data'
        @routes.push payload

    @inPorts.add 'current_route',
      datatype: 'string',
      description: 'current active route'
    , (event, payload) =>
      if event is 'data'
        @currentRoute = payload

    @inPorts.add 'key',
      datatype: 'int',
      description: 'key that activates shortcut'
    , (event, payload) =>
      if event is 'data'
        @key = parseInt payload

    @inPorts.add 'keypress',
      datatype: 'int',
      description: 'key that was pressed'
    , (event, payload) =>
      if event is 'data' and payload.keyCode is @key and @currentRoute in @routes
        @outPorts.out.send payload

    @outPorts.add 'out'

exports.getComponent = -> new ShortcutRouter
