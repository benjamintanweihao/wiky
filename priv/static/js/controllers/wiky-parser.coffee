angular.module('wiky')
  .controller 'WikyParserCtrl', [
    '$scope', '$http',
    ($scope ,  $http) ->
      $scope.progressText       = "not started"
      $scope.progressPercentage = 0
      socket = new Phoenix.Socket("/ws")
       
      $scope.start = ->
        socket.join("wiky-parser-channel", "start-parser", {}, (channel) ->
          channel.on("progress", (message) ->
            $scope.progressPercentage = message.progress_percentage
            $scope.progressText       = message.progress_status
            $scope.$apply($scope.progressPercentage)
            $scope.$apply($scope.progressText)
          )
        )

      $scope.generateSentence = ->
        word = $scope.seedPrefix.trim()

        $http.get('/generate_sentence', 
            params:
              seed_prefix: word
          ).
          success((data, status, headers, config) ->
            $scope.generatedSentence = data.result
          ).
          error((data, status, headers, config) ->
            alert(data)
          )
  ]

