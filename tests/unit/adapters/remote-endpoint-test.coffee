`import { moduleFor, test } from 'ember-qunit'`

moduleFor 'adapter:remote-endpoint', 'RemoteEndpointAdapter', {
  # Specify the other units that are required for this test.
  # needs: ['serializer:foo']
}

# Replace this with your real tests.
test 'it exists', ->
  adapter = @subject()
  ok adapter
