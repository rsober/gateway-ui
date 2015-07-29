`import DS from 'ember-data'`
`import Model from './model'`
`import config from  '../config/environment'`

ProxyEndpointTest = Model.extend
  name: DS.attr 'string', defaultValue: 'Test'
  method: DS.attr 'string', defaultValue: 'get'
  route: DS.attr 'string'
  content_type: DS.attr 'string', defaultValue: ''
  body: DS.attr 'string'
  pairs: DS.hasMany 'proxy-endpoint-test-pairs'
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'
  methodsArray: Ember.computed 'method', ->
    methods = []
    methods.push(@get('method').toUpperCase()) if @get('method')
    methods.compact()
  addContentType: Ember.observer 'method', ->
    method = @get('method')
    oldMethod = @get('_oldMethod')
    header = @get('pairs').find (item) ->
      item.get('type') == 'header' && item.get('key') == 'Content-Type'
    if (method == 'get' || method == 'delete') && header
      header.deleteRecord()
    else if method == 'post' || method == 'put'
      if !header
        header = @store?.createRecord 'proxy-endpoint-test-pair'
        header.set('type', 'header')
        header.set('key', 'Content-Type')
        @get('pairs').pushObject header
      if method == 'post' && oldMethod && oldMethod != 'post'
        @set('content_type', 'application/x-www-form-urlencoded')
      else if method == 'put' && oldMethod && oldMethod != 'put'
        @set('content_type', 'application/json')
    @set('_oldMethod', method)
  updateContentType: Ember.observer 'content_type', ->
    header = @get('pairs').find (item) ->
      item.get('type') == 'header' && item.get('key') == 'Content-Type'
    header?.set('value', @get('content_type'))
  pairsDirty: Ember.computed 'pairs.@each.isDirty', ->
    @get('pairs').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'pairsDirty', ->
    @get('pairsDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'
  reload: ->
    @get('proxy_endpoint').reload()
  rollback: ->
    @get('pairs')?.forEach (record) -> record.rollback()
    @_super.apply @, arguments
  save: ->
    # delegate save to parent proxy endpoint and then
    # "rollback" to now-saved embedded record
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('errors').clear()
      @get('proxy_endpoint').save().then (=>
        @rollback()
        @get('proxy_endpoint')?.rollback()
        resolve @
      ), (-> reject @)
  deleteRecord: ->
    @_super.apply @, arguments
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    proxyEndpoint = @get 'proxy_endpoint'
    proxyEndpoint.save().then (->
      proxyEndpoint.rollback()
    ), (=>)
  testUrl: Ember.computed ->
    url = []
    url.push config.api.url
    url.push 'apis'
    url.push @get('proxy_endpoint.api.id')
    url.push 'proxy_endpoints'
    url.push @get('proxy_endpoint.id')
    url.push 'tests'
    url.push @get('id')
    url.push 'test'
    url = url.join '/'
    host = "#{window.location.protocol}//#{window.location.host}"
    url = "#{host}#{url}" if !config.api.host
    url

`export default ProxyEndpointTest`
