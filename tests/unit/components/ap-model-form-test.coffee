`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'ap-model-form', 'ApModelFormComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['component:ap-form-actions']
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