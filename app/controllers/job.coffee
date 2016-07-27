angular.module('letter-job').controller "Job", ($scope, job) ->
  console.log 'jobcotr', arguments
  $scope.job = job
  $scope.jobProgress = job.progress()
