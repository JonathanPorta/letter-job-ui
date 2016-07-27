Backbone = require 'backbone'

module.exports = class JobsCollection extends Backbone.Collection

  url: -> "/users/#{ @user.id }/#{ @type }"
  model: require '../models/job.coffee'

  initialize: (attributes, options) ->
    console.log 'jobs.coffee', arguments

    @user = options.user
    @type = options.type

    @listenTo @user, 'sync', => @fetch()
