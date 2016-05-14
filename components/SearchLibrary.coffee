noflo = require 'noflo'

class SearchLibrary extends noflo.Component
  constructor: ->
    super
    @outPorts.add 'out'

    # Element no available until page is loaded
    # TODO: Find a better way to do this
    window.setTimeout =>
      @outPorts.out.send document.getElementById("container").shadowRoot.getElementById("search")
    , 0

exports.getComponent = -> new SearchLibrary
