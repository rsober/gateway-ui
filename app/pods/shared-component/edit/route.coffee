`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SharedComponentEditRoute = EditRoute.extend AuthenticatedRouteMixin,
  afterModel: ->
    #@model.populateRelationships()

`export default SharedComponentEditRoute`
