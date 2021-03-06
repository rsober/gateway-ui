`import BaseForm from 'gateway-ui/pods/components/forms/base-form/component'`

SharedComponentTransformationFormComponent = BaseForm.extend
  'option-groups': null # passed in by controllers

  modelType: 'shared-component-transformation'

  before: false
  after: false

  fields: Ember.computed 'before', 'after', ->
    typeLabel = 'fields.type'
    bodyLabel = 'fields.logic'
    if @get 'before'
      typeLabel = 'fields.before-type'
      bodyLabel = 'fields.before'
    if @get 'after'
      typeLabel = 'fields.after-type'
      bodyLabel = 'fields.after'
    [
      name: 'body'
      label: bodyLabel
      type: 'javascript'
    ]

`export default SharedComponentTransformationFormComponent`
