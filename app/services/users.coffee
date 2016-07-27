q = require 'q'
$ = require 'jquery'

UserModel = require '../models/user.coffee'

class UsersService

  url: -> '/users'

  constructor: ->
    console.log 'init users service!'
    @currentUser = null

  isAuthenticated: ->
    if @currentUser && @currentUser.loaded
      true
    else
      false

  login: ->
    q.fcall =>
      return @currentUser if @isAuthenticated()

      deferred = q.defer()

      # Since we are logging in, we need to simi-block the UI, so we wait for this callback.
      req = $.ajax
        url: '/me.json'
        method: 'GET'
        success: (data, response) =>
          @currentUser = new UserModel data
          @currentUser.assignments.fetch()
          @currentUser.creations.fetch()
          deferred.resolve @currentUser
        error: (error, response) =>
          @currentUser = null
          deferred.reject error

      # pinky-swear
      deferred.promise

angular.module('letter-job').service 'UsersService', -> new UsersService()
