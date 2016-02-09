`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

HostEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default HostEditRoute`