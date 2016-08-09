angular.module('letter-job').controller "Job", ($scope, job) ->
  console.log 'jobcotr', arguments, job
  # job.then (job) =>
  $scope.job = job
  # if $scope.job?.isLoaded?
  #   console.log 'job loaded'
  #   $scope.job.on 'all', =>
  #     console.log "'$scope.job.on 'all', =>'"
  $scope.jobProgress = job.progress()
  $scope.tasksLeft = job.incompleteTasks().length
  $scope.tasks = job.incompleteTasks()

    #
    # $scope.job.tasks.on 'all', =>
    #   console.log "'$scope.job.tasks.on 'all', =>'"
    #   $scope.jobProgress = job.progress()
    #   $scope.tasksLeft = job.incompleteTasks().length
    #   $scope.tasks = job.incompleteTasks()
