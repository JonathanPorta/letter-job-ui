Backbone = require 'backbone'

module.exports = class TaskModel extends Backbone.Model

  url: -> "/tasks/#{ @id }.json"

  initialize: (attributes, options) ->
    console.log 'task model', @

  isComplete: ->
    @get('status') == 'complete'
