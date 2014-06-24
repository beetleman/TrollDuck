define (require, exports, module) ->

  # Makes touch events in Backbone easy, see: https://github.com/wookiehangover/backbone.hammer
  require('hammerjs')
  require('jquery-hammerjs')
  require('backbone-hammer')

  _            = require('underscore')
  $            = require('jquery')
  Backbone     = require('backbone')
  TrollDuckRouter = require('routers/trollduck_router')
  TrollDuckView   = require('views/trollduck_view')

  ###
    We'll use this file to boot up our application. It's extending Backbone.View, but
    isn't really used as a view at all. You'll want to replace all Backbone code in
    this project with your own, it only exists to show you how requiring various
    components in the application work together and it not intended to be an example
    of a well structured or well built application. A sensible application architecture
    # is up to you, as it's not something Backbone really prescribes.
  ###

  class TrollDuckApp extends Backbone.View

    initialize: ->
      # Create our routers
      @router = new TrollDuckRouter
        app: @

      # Create our views
      @trollDuckView = new TrollDuckView

      # Start backbone history
      Backbone.history.start()
