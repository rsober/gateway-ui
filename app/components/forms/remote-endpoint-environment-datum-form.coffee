`import BaseRemoteEndpointFormComponent from './base-remote-endpoint-form'`

RemoteEndpointEnvironmentDatumFormComponent = BaseRemoteEndpointFormComponent.extend
  indexModel: null
  environments: null
  remoteEndpointType: null
  modelType: 'remote-endpoint-environment-datum'

  savedAction: null

  'option-groups': Ember.computed 'environments.@each.isNew', ->
    Ember.merge @_super.apply(@, arguments),
      environment: @get('environments').filterBy 'isNew', false

  defaultFields: [
      name: 'environment'
      label: 'resources.environment'
      type: 'select-model-name'
      required: true
    ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      indexModel = @get 'indexModel'
      remoteEndpointType = @get 'remoteEndpointType'
      model.set 'type', remoteEndpointType
      indexModel.pushObject model
    @_super.apply @, arguments

  actions:
    saved: ->
      @notifySaveSuccess()
      # resend this action (using a different name)
      # so that the router can handle it if necessary
      @send 'saved'

`export default RemoteEndpointEnvironmentDatumFormComponent`