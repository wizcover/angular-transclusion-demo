@app.directive 'tgRepeat', ($compile) ->
  restrict: 'A'
  transclude: true
  scope:
    items: '='
  template: "
  <table>
    <thead></thead>
    <tbody></tbody>
    <tfoot></tfoot>
  </table>
  "
  controller: ($scope, $element, $transclude, $compile) ->
    head = $element.find('thead')
    body = $element.find('tbody')
    foot = $element.find('tfoot')

    $transclude (clone) ->
      transclude_head = angular.element('<div>').append(clone).find('thead')
      body.append transclude_head.contents()

    $transclude (clone) ->
      transclude_foot = angular.element('<div>').append(clone).find('tfoot')
      body.append transclude_foot.contents()

    $scope.items.forEach (item) ->
      $transclude (clone, transclusion_scope) ->
        scope = transclusion_scope.$new()
        scope.item = item
        item_body = angular.element('<div>').append(clone).find('tbody').find('tr').clone()
        body.append $compile(item_body)(scope)
