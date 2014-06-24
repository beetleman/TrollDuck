define (require, exports, module) ->
  JST = require('tmpl')
  Backbone = require('backbone')
  Widget   = require('models/widget')

  class WidgetView extends Backbone.View
    tmpl: JST['assets/javascripts/app/templates/trollduck.html']
    el: "#app"

    hammerEvents:
      "touch button.duck"    : "addDuck"

    # initialize: ->
    #   @listenTo @collection, 'add remove', @updateDucks

    render: ->
      @$el.html @tmpl({})

    addDuck: ->
      conslole.log('Kfaaaa')
