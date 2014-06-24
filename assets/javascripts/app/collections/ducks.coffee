define (require, exports, module) ->

  Backbone = require('backbone')
  Duck = require('models/duck')

  class Ducks extends Backbone.Collection

    model: Duck
