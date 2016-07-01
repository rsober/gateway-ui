`import BaseFormComponent from 'gateway/components/forms/base-form'`

PushDeviceFormComponent = BaseFormComponent.extend
  savedAction: null
  indexModel: null
  modelType: 'push-device'

  defaultFields: [
      name: 'name'
      required: true
    ,
      name: 'type'
      type: 'select'
      required: true
    ,
      name: 'token'
      required: true
    ,
      name: 'expires'
      type: 'datetime'
      required: true
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      pushDevices = @get 'indexModel'
      pushDevices.pushObject model
    @_super arguments...

`export default PushDeviceFormComponent`
