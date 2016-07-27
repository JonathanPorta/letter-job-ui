Backbone = require 'backbone'
_ = require 'underscore'

JobsCollection = require '../collections/jobs.coffee'

module.exports = class UserModel extends Backbone.Model

  url: -> "/users/#{ @id }.json"

  initialize: (attributes, options) ->
    console.log arguments

    @assignments = new JobsCollection [], user: @, type: 'assignments'
    @creations = new JobsCollection [], user: @, type: 'creations'

    @loaded = @isLoaded()
    @on 'all', ->
      @loaded = @isLoaded()

  isLoaded: ->
    # Consider a user loaded if they have an id, a role, and an e-mail.
    @attributes.id? && @attributes.role? && @attributes.email?

  name: ->
    "#{ @get('first_name') } #{ @get('last_name') }"

  jobsToDo: ->
    @assignments.models

  nextJob: ->
    @assignments.at 0

  isAuthorizedFor: (roles) ->
    if !_.isArray roles
      roles = [roles]

    # If the user is authorized for any of the roles then return true
    _.some roles (role)->
      @get('role') == role
