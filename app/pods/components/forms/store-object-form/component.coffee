`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

StoreObjectFormComponent = BaseFormComponent.extend
  savedAction: null
  indexModel: null
  modelType: 'store-object'
  horizontal: false

  defaultFields: [
    name: 'body'
    label: false
    type: 'json'
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      indexModel = @get 'indexModel'
      indexModel.pushObject model
    @_super arguments...

`export default StoreObjectFormComponent`
