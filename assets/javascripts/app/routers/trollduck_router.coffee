define (require, exports, module) ->

  Backbone = require('backbone')

  class WidgetRouter extends Backbone.Router

    routes:
      "": "trollduck" # This is a default route.

    initialize: (options) ->
      @app = options.app

    trollduck: ->
      @app.trollDuckView.render()
