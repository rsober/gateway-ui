`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

EndpointGroupsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'endpoint_groups'

`export default EndpointGroupsRoute`
