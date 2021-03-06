`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

SharedComponentCallSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    shared_component:
      serialize: false
    before:
      embedded: 'always'
    after:
      embedded: 'always'

  normalize: (type, hash, property) ->
    hash.before = [] if !hash.before
    hash.after = [] if !hash.after
    @_super.apply @, arguments

`export default SharedComponentCallSerializer`
