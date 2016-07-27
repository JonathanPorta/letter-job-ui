q = require 'q'
$ = require 'jquery'

TaskModel = require '../models/task.coffee'

class TasksService

  constructor: ->
    console.log 'init tasks service!'

  find: (id) ->
    d = q.defer()
    model = new TaskModel id: id
    model.fetch
      success: =>
        d.resolve model
      error: (error)=>
        d.reject "Unable to load task with id '#{ id }': #{ error }"

    d.promise

angular.module('letter-job').service 'TasksService', -> new TasksService()
