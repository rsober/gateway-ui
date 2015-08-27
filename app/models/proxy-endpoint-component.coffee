`import DS from 'ember-data'`
`import Model from './model'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponent = Model.extend
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true
  body: DS.attr 'string', defaultValue: ''

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  call: DS.belongsTo 'proxy-endpoint-component-call',
    async: false
    stains: true
    embedded: true
  calls: DS.hasMany 'proxy-endpoint-component-call',
    async: false
    stains: true
    embedded: true
  before: DS.hasMany 'proxy-endpoint-component-transformation',
    async: false
    stains: true
    embedded: true
  after: DS.hasMany 'proxy-endpoint-component-transformation',
    async: false
    stains: true
    embedded: true

  # computed
  single: Ember.computed 'type',
    get: -> @get('type') == 'single'
    set: (key, value) ->
      @set 'type', 'single' if value?
      @get 'single'
  multi: Ember.computed 'type',
    get: -> @get('type') == 'multi'
    set: (key, value) ->
      @set 'type', 'multi' if value?
      @get 'multi'
  js: Ember.computed 'type',
    get: -> @get('type') == 'js'
    set: (key, value) ->
      @set 'type', 'js' if value?
      @get 'js'
  name: Ember.computed 'type', ->
    t(switch @get 'type'
        when 'single' then 'proxy-endpoint-component-types.single-proxy'
        when 'multi' then 'proxy-endpoint-component-types.multi-proxy'
        when 'js' then 'proxy-endpoint-component-types.javascript-logic').capitalize()

`export default ProxyEndpointComponent`
