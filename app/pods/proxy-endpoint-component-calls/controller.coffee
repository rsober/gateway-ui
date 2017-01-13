`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

ProxyEndpointComponentCallsController = Ember.Controller.extend
  breadCrumb: 'resources.proxy-endpoint-component-call_plural'

  'api': Ember.inject.controller()

  indexModel: Ember.computed.alias 'model'
  'option-groups': Ember.computed 'api.libraries', 'api.remote_endpoints.@each.isNew', ->
    conditional: @get 'api.libraries'
    remote_endpoint: @get('api.remote_endpoints').filterBy 'isNew', false

  'transformation-option-groups': Ember.computed 'api.libraries', ->
    body: @get 'api.libraries'
    type: [
      name: t('languages.javascript').capitalize()
      value: 'js'
    ]

`export default ProxyEndpointComponentCallsController`
