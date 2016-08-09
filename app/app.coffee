app = angular.module 'letter-job', ['ngMaterial', 'ui.router']

app.run ($rootScope, $state, $stateParams, AuthorizationService, UsersService) ->
  $rootScope.$on "$stateChangeError", ->
    console.error 'Error Changing state', arguments

  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams

  $rootScope.$on '$stateChangeStart', (event, toState, toStateParams) ->
    console.log "$rootScope.$on '$stateChangeStart', (event, toState, toStateParams) ->", arguments
    AuthorizationService.isAuthorizedFor(toState, toStateParams)

app.config ($mdThemingProvider, $urlRouterProvider, $stateProvider) ->
  # Add router here if we need one
  $urlRouterProvider.otherwise '/me'

  $stateProvider.state 'login',
    authentication: false
    url: '/login'
    controller: 'Login'
    templateProvider: ($templateCache) ->
      $templateCache.get 'partials/login'

  $stateProvider.state 'app',
    abstract: true
    template: '<div ui-view></div>'
    resolve:
      user: (UsersService, $rootScope) ->
        # console.log 'user: (UsersService, $state) ->', $rootScope.$state
        # if $rootScope.$state.current.authentication
        UsersService.login()
        # else
          # null

  $stateProvider.state 'app.me',
    roles: ['admin', 'user']
    authentication: true
    url: '/me'
    controller: 'Me'
    templateProvider: ($templateCache) ->
      $templateCache.get 'partials/me'

  $stateProvider.state 'app.job',
    abstract: true
    controller: 'Job'
    url: '/jobs/:job_id'
    resolve:
      job: (JobsService, $stateParams) ->
        JobsService.find $stateParams.job_id
    templateProvider: ($templateCache) ->
      $templateCache.get 'partials/job-progress-header'

  $stateProvider.state 'app.job.task',
    roles: ['admin', 'user']
    authentication: true
    url: '/tasks/:task_id'
    controller: 'Task'
    resolve:
      task: (TasksService, $stateParams) ->
        TasksService.find $stateParams.task_id
    templateProvider: ($templateCache) ->
      $templateCache.get 'partials/task'

  $stateProvider.state 'app.job.task.verify',
    roles: ['admin', 'user']
    authentication: true
    url: '/verify'
    controller: 'TaskVerify'
    templateProvider: ($templateCache) ->
      $templateCache.get 'partials/task.verify'
