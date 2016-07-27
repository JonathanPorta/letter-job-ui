angular.module('letter-job').controller "TaskVerify", ($scope, task) ->
  console.log 'taskverifyctrl', arguments
  $scope.task = task
  $scope.title = task.get 'title'
  $scope.description = task.get 'description'
