`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`

ApJsonNodeTreeComponent = BsBaseComponent.extend
  tagName: 'ul'
  classNames: ['ap-json-node-tree']

  selectAction: 'select'
  deleteAction: 'delete'

  selectedNode: null
  model: null # should be root instance of json-node

  defaultSelected: Ember.on 'init', -> @onModelChange()
  onModelChange: Ember.observer 'model', -> @send 'select', @get('model')

  actions:
    select: (model) ->
      @set 'selectedNode', model
      @sendAction 'selectAction', model
    delete: (model) ->
      selectedModel = @get 'selectedModel'
      @send 'select', null if model is selectedModel
      model.deleteRecord()
      @sendAction 'deleteAction', model
    new: (model) ->
      newChild = model.get('children').createRecord()
      @send 'select', newChild

`export default ApJsonNodeTreeComponent`
