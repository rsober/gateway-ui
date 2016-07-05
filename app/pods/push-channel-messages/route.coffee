`import Ember from 'ember'`

PushChannelMessagesRoute = Ember.Route.extend
  model: -> @store.findAll 'push-channel-message'
  afterModel: ->
    Ember.RSVP.hash
      push_channels: @store.findAll 'push-channel'
    .then (results) =>
      @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels
    @_super arguments...
  renderTemplate: ->
    @_super arguments...
    @render 'push/secondary-sidebar',
      outlet: 'sidebar'
      into: 'push-channel-messages'

`export default PushChannelMessagesRoute`
