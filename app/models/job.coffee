Backbone = require 'backbone'

TasksCollection  = require '../collections/tasks.coffee'

module.exports = class JobModel extends Backbone.Model

  url: -> "/jobs/#{ @id }.json"

  initialize: (attributes, options) ->
    console.log 'job model', @

    @tasks = new TasksCollection [], job: @

  isComplete: ->
    !@tasks.some (task) ->
      console.log "!@tasks.some (task) -> ", task
      !task.isComplete()

  progress: ->
    return 0 if @tasks.length == 0
    complete = @tasks.filter (task) -> task.isComplete()
    Math.floor(complete.length / @tasks.length)

  nextTask: ->
    if !@isComplete()
      @tasks.find (m) -> !m.isComplete()
    else
      false
