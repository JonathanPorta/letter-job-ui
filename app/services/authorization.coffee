class AuthorizationService

  constructor: ($rootScope, $state, UsersService) ->
    console.log 'init auth service!', arguments
    @$rootScope = $rootScope
    @$state = $state
    @UsersService = UsersService
    console.log 'INITIAL VALUES FOR rootScope and state', @$rootScope, @$state

  isAuthorizedFor: (state, params)->
    console.log 'isAuthorizedFor: (state, params)->', arguments
    # If authentication isn't set or roles isn't set, then let them access the
    # state because obviously no one cares enough to set the correct authorization attributes.
    return true if (!state.authentication? || !state.roles?) || !state.authentication
    console.log 'Made it past', '!state.authentication? || !state.roles? || !state.authentication'
    @UsersService.login().finally =>
      console.log '@UsersService.login().done ->', arguments

      # If the state requires authentication and the user is not authorized for any of this state's roles,
      # make sure they are logged in. if so, they are not authorized.
      # otherwise, bounce them to login screen.
      if @UsersService.isAuthenticated()
        console.log "@UsersService.isAuthenticated()"
        user = @UsersService.currentUser()
        if user.isInAnyRole state.roles
          console.log "if user.isInAnyRole state.roles"
          true
        else
          console.log 'else for if user.isInAnyRole state.roles'
          @$state.go 'app.unauthorized'
      else
        console.log 'else for if @UsersService.isAuthenticated()'
        # // user is not authenticated. Stow
        # // the state they wanted before you
        # // send them to the sign-in state, so
        # // you can return them when you're done
        @$rootScope.returnToState = state
        @$rootScope.returnToStateParams = params

        # // now, send them to the signin state
        # // so they can log in
        @$state.go 'login'

angular.module('letter-job').service 'AuthorizationService', ($rootScope, $state, UsersService) ->
  new AuthorizationService $rootScope, $state, UsersService
