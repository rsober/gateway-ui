`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: -> @transitionTo 'remote-endpoint-environment-datum.edit'

`export default RemoteEndpointEnvironmentDatumIndexRoute`