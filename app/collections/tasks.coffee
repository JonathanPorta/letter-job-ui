Backbone = require 'backbone'

module.exports = class TasksCollection extends Backbone.Collection

  url: -> "/jobs/#{ @job.id }/tasks"
  model: require '../models/task.coffee'

  initialize: (attributes, options) ->
    console.log 'TasksCollection init', @
    @job = options.job

    @listenTo @job.collection, 'sync', => @fetch
      complete: () =>
        console.log 'taskscollection SYNCED!', @models

    @on 'sync', =>
      @job.collection.trigger 'sync:tasks'
