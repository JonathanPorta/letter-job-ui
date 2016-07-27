q = require 'q'
$ = require 'jquery'

JobModel = require '../models/job.coffee'

class JobsService

  constructor: ->
    console.log 'init jobs service!'

  find: (id) ->
    d = q.defer()
    model = new JobModel id: id
    model.fetch
      success: =>
        d.resolve model
      error: (error)=>
        d.reject "Unable to load job with id '#{ id }': #{ error }"

    d.promise

angular.module('letter-job').service 'JobsService', -> new JobsService()
