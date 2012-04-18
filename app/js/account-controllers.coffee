log = utils.log
focus = utils.focus


AccountController = ($scope)->
  log($scope.session)
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


ImportController = ($scope, friendDAO, stuffDAO)->
  $scope.importDataText = ''
  $scope.startImport = ->
    importData = JSON.parse($scope.importDataText)
    if importData?.stuff
      stuffDAO.save(importData.stuff)
    if importData?.stuff
      friendDAO.save(importData.friends)
    window.alert("Import Done!")
    $scope.importDataText = ''


ImportController.$inject = ['$scope', 'friendDAO', 'stuffDAO']


#export
this.AccountController = AccountController
this.ExportController = ExportController
this.ImportController = ImportController
