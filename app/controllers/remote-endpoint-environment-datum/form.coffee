`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointEnvironmentDatumFormController = FormController.extend
  needs: ['remote-endpoints', 'remote-endpoint-environment-data']
  modelType: 'remote-endpoint-environment-datum'
  'option-groups': Ember.computed 'controllers.remote-endpoints.environments', ->
    environment: @get('controllers.remote-endpoints.environments').filterBy 'isNew', false
    method: [
      name: t 'http-methods.get'
      value: 'GET'
    ,
      name: t 'http-methods.post'
      value: 'POST'
    ,
      name: t 'http-methods.put'
      value: 'PUT'
    , 
      name: t 'http-methods.delete'
      value: 'DELETE'
    ]
  createNewModel: ->
    newModel = @_super.apply @, arguments
    environment_data = @get 'controllers.remote-endpoint-environment-data.model'
    environment_data.pushObject newModel


`export default RemoteEndpointEnvironmentDatumFormController`
