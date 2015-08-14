`import FormController from 'gateway/controllers/form'`

# note:  this form is currently used only for multi proxy calls

ProxyEndpointComponentCallFormController = FormController.extend
  needs: ['proxy-endpoints', 'proxy-endpoint-component-calls']
  modelType: 'proxy-endpoint-component-call'
  'option-groups': Ember.computed 'controllers.proxy-endpoints.remote_endpoints.[]', ->
    remote_endpoint: @get('controllers.proxy-endpoints.remote_endpoints').filterBy 'isNew', false
  fields: Ember.computed 'model.isNew', ->
    newFields = [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ]
    editFields = [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ,
      name: 'conditional_positive'
      type: 'conditional-positive'
    ,
      name: 'conditional'
      label: 'fields.call-conditional'
      type: 'javascript'
    ]
    if @get 'model.isNew' then newFields else editFields
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        if model.get('before.length') == 0
          newBefore = @store?.createRecord 'proxy-endpoint-component-transformation'
          model.get('before').pushObject newBefore
        if model.get('after.length') == 0
          newAfter = @store?.createRecord 'proxy-endpoint-component-transformation'
          model.get('after').pushObject newAfter
        calls = @get 'controllers.proxy-endpoint-component-calls.model'
        calls.pushObject model

`export default ProxyEndpointComponentCallFormController`
