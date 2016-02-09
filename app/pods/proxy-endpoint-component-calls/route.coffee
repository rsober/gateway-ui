`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointComponentCallsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('proxy-endpoint-component').get 'calls'

`export default ProxyEndpointComponentCallsRoute`