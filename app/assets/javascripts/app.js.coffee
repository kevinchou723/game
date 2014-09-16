# Define App and dependencies
GameApp = angular.module("GameApp", ["ngRoute", "templates"])

# Setup the angular router
GameApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
    $routeProvider
        .when '/',
            templateUrl: "index.html",
            controller: "GamesCtrl"
    .otherwise
            redirectTo: "/"

    $locationProvider.html5Mode(true)

]

# Games Controller
GameApp.controller "GamesCtrl", ["$scope", "$http", ($scope, $http) ->
    $scope.words = []

    $scope.addWord = ->
        $http.post("/words.json", $scope.newWord).success (data) ->
            $scope.newWord = {}
            $scope.words.push(data)

    $scope.removeWord = ->
        $http.delete("/words/#{word.id}.json").success (data) ->
            $scope.words.splice($scope.words.indexOf(word),1)

]

# Define Config for CSRF token
GameApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]