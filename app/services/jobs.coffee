JobModel = require '../models/job.coffee'

class JobsService

  constructor: ($q) ->
    @$q = $q
    console.log 'init jobs service!'

  find: (id) ->
    d = @$q.defer()
    model = new JobModel id: id
    model.fetch
      success: =>
        model.tasks.fetch
          success: =>
            d.resolve model
          error: (error)=>
            d.reject "Unable to load tasks for job with id '#{ id }': #{ error }"
      error: (error)=>
        d.reject "Unable to load job with id '#{ id }': #{ error }"

    d.promise

angular.module('letter-job').service 'JobsService', ($q) ->
  new JobsService $q
