log = utils.log
focus = utils.focus


AccountController = ($scope)->
  $scope.export = ->
    $scope.exportedData = "Bla"
    focus('exportTextarea')


AccountController.$inject = ['$scope']


ExportController = ($scope, friendDAO, stuffDAO)->
  $scope.export = ->
    stuffDAO.list (stuffList)->
      friendDAO.list (friendList)->
        $scope.exportedData = JSON.stringify({stuff: stuffList, friends: friendList})
        focus('exportTextarea')


ExportController.$inject = ['$scope', 'friendDAO', 'stuffDAO']


ImportController = ($scope)->
  $scope.export = ->
    $scope.exportedData = "Bla"
    focus('exportTextarea')

ImportController.$inject = ['$scope']


#export
this.AccountController = AccountController
this.ExportController = ExportController
this.ImportController = ImportController
