`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'host', 'Unit | Model | host', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
