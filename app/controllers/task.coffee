angular.module('letter-job').controller "Task", ($scope, task, $sce) ->
  console.log 'taskctrl', arguments
  $scope.task = task
  $scope.taskId = task.id
  $scope.jobId = task.get 'job_id'
  $scope.title = task.get 'title'
  $scope.description = $sce.trustAsHtml task.get('description')
