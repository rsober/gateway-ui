`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

JobController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'
  'tertiary-layout-header': Ember.computed 'model.name', ->
    t 'headers.x-workflow', x: @get 'model.name'

`export default JobController`
