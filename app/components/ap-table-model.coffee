`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import Notify from 'ember-notify'`

ApTableModelComponent = BsBaseComponent.extend
  classNames: ['ap-table-model']
  models: null # array of model instances
  'delete-action': 'delete'
  'auto-delete': true
  'edit-path': null
  'partial-path': null
  'custom-primary-action': null
  'custom-primary-icon': null
  'custom-primary-t': null
  delete: (record) ->
    record.destroyRecord().catch =>
      @notifyErrorsForRecord record
      @cancelDelete record
  cancelDelete: (record) ->
    record.rollback()
    record.transitionTo 'loaded.saved' # clear deleted state
    record.reload().then ->
      record.rollback()
  notifyErrorsForRecord: (record) ->
    errors = []
    record.get('errors').forEach (error) ->
      Notify.alert error.message
  actions:
    'custom-primary': (record) ->
      @sendAction 'custom-primary-action', record
    delete: (record) ->
      if @get 'auto-delete'
        @delete record
      else
        @sendAction 'delete-action', record

`export default ApTableModelComponent`
