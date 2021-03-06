`import Ember from 'ember'`
`import EditController from 'gateway-ui/pods/edit/controller'`

# Account index is actually an edit controller.
AccountIndexController = EditController.extend
  breadCrumb: null
  account: Ember.inject.controller()
  plans: Ember.computed.alias 'account.plans'

`export default AccountIndexController`
