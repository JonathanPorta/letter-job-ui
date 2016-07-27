angular.module('letter-job').controller "Me", ($scope, user) ->
  $scope.user = user

  if $scope.user?.isLoaded?
    $scope.user.on 'all', =>
      $scope.$apply =>
        $scope.jobsToDoCount = $scope.user.jobsToDo().length
        console.log '$scope.user.jobsToDo.length', $scope.user.jobsToDo.length

    $scope.user.assignments.on 'all', =>
      console.log 'event!!!!!!'
      $scope.$apply =>
        $scope.jobsToDoCount = $scope.user.jobsToDo().length
        if $scope.jobsToDoCount > 0
          $scope.firstJobId = $scope.user.nextJob().id
          console.log "  $scope.firstJobId = $scope.user.nextJob().id", $scope.firstJobId
          console.log "$scope.user.nextJob()", $scope.user.nextJob()
          console.log "$scope.user.nextJob().nextTask()", $scope.user.nextJob().nextTask()
          $scope.firstTaskId = $scope.user.nextJob().nextTask().id
