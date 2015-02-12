`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'ap-model-field', 'ApModelFieldComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['template:components/ap-model-field/-string']
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'