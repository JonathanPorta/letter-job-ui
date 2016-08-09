Backbone = require 'backbone'

TasksCollection  = require '../collections/tasks.coffee'

module.exports = class JobModel extends Backbone.Model

  url: -> "/jobs/#{ @id }.json"

  initialize: (attributes, options) ->
    console.log 'job model', @

    @tasks = new TasksCollection [], job: @

    @loaded = @isLoaded()
    @on 'all', ->
      @loaded = @isLoaded()

  isLoaded: ->
    # Consider a job loaded if they have an id
    # toDO: should listen to tasks collection
    @attributes.id?

  isComplete: ->
    !@tasks.some (task) ->
      !task.isComplete()

  incompleteTasks: -> @tasks.filter (task) -> !task.isComplete()
  completeTasks: -> @tasks.filter (task) -> task.isComplete()

  progress: ->
    return 0 if @tasks.length == 0
    complete = @completeTasks()
    Math.floor(complete.length / @tasks.length)

  nextTask: ->
    if !@isComplete()
      @tasks.find (m) -> !m.isComplete()
    else
      false
