(function() {
  angular.module('wiky').controller('WikyParserCtrl', [
    '$scope', '$http', function($scope, $http) {
      var socket;
      $scope.progressText = "not started";
      $scope.progressPercentage = 0;
      socket = new Phoenix.Socket("/ws");
      $scope.start = function() {
        return socket.join("wiky-parser-channel", "start-parser", {}, function(channel) {
          return channel.on("progress", function(message) {
            $scope.progressPercentage = message.progress_percentage;
            $scope.progressText = message.progress_status;
            $scope.$apply($scope.progressPercentage);
            return $scope.$apply($scope.progressText);
          });
        });
      };
      return $scope.generateSentence = function() {
        var word;
        word = $scope.seedPrefix.trim();
        return $http.get('/generate_sentence', {
          params: {
            seed_prefix: word
          }
        }).success(function(data, status, headers, config) {
          return $scope.generatedSentence = data.result;
        }).error(function(data, status, headers, config) {
          return alert(data);
        });
      };
    }
  ]);

}).call(this);
