`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'ap-table-index-row', 'ApTableIndexRowComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: [
    'component:ap-table-index-cell'
    'component:ap-list-nav-simple-icon'
    'component:ap-list-link'
  ]
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'

# TODO
