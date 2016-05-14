noflo = require 'noflo'

class SearchLibrary extends noflo.Component
  constructor: ->
    super
    @outPorts.add 'out'

    window.setTimeout =>
      @outPorts.out.send document.getElementById("container").shadowRoot.getElementById("search")
    , 0

exports.getComponent = -> new SearchLibrary
