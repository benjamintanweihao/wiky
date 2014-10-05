(function() {
  angular.module('wiky').controller('WikyParserCtrl', [
    '$scope', '$http', function($scope, $http) {
      var socket;
      $scope.progressText = "not started";
      $scope.progressPercentage = 0;
      socket = new Phoenix.Socket("/ws");
      return $scope.start = function() {
        return socket.join("wiky-parser-channel", "start-parser", {}, function(channel) {
          return channel.on("progress", function(message) {
            $scope.progressPercentage = message.progress_percentage;
            $scope.progressText = message.progress_status;
            $scope.$apply($scope.progressPercentage);
            return $scope.$apply($scope.progressText);
          });
        });
      };
    }
  ]);

}).call(this);
