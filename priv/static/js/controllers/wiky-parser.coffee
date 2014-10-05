angular.module('wiky')
  .controller 'WikyParserCtrl', [
    '$scope', '$http',
    ($scope ,  $http) ->
      $scope.progressText       = "Not started."
      $scope.progressPercentage = 30

      socket = new Phoenix.Socket("/ws")

      socket.join("wiky-parser-channel", "start-parser", {}, (channel) ->
        channel.on("progress", (message) ->
          $scope.progressPercentage = message.progress_percentage
          $scope.progressText       = message.progress_status
          $scope.$apply($scope.progressPercentage)
          $scope.$apply($scope.progressText)
        )
      )

        
  ]
