`import ApplicationAdapter from 'gateway/adapters/application'`
`import t from 'gateway/helpers/i18n'`

PushChannelPushManualMessageAdapter = ApplicationAdapter.extend
  errorMappings:
    data: 'body'

  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'push_channel', 'push_manual_messages'

  # Raises a JSON serialization error if the serializer
  # reports that one occured.
  ajax: (url, type, options) ->
    hasError = options?.data?.push_manual_message?.dataError
    if hasError
      Ember.RSVP.reject new DS.InvalidError [
        detail: t 'errors.invalid-json'
        source:
          pointer: '/data/attributes/body'
      ]
    else
      @_super arguments...

`export default PushChannelPushManualMessageAdapter`