angular.module('letter-job').controller "Login", ($scope, $state, UsersService) ->
  # $scope.user = null
  # $scope.message = ''
  console.log 'login:$scope', $scope, $scope.user
  # UsersService.login (error, user) ->
  #   if error
  #     console.log 'not logged  in', error, user
  #     $scope.message = error
  #   else
  #     console.log 'logged in', user
  #     $scope.user = user
  #     $scope.message = 'Logged in!'
  #     $state.go 'me'
