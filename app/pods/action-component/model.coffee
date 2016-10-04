`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`
`import t from 'gateway/helpers/i18n'`

ActionComponent = Model.extend
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true
  body: DS.attr 'string', defaultValue: ''
  # Maps to proxy_endpoint_component_id, see serializer.
  # Using `proxy_endpoint_component_id` is apparently problematic for
  # no apparent reason.
  pass_through_id: DS.attr 'number'

  # Relationships
  shared_component: DS.belongsTo 'shared-component',
    async: false
    stains: true

  # computed
  typeKind: Ember.computed 'type', 'shared_component.typeKind', ->
    sharedTypeKind = @get 'shared_component.typeKind'
    type = @get 'type'
    sharedTypeKind or ActionComponent.types.findBy('value', type)
  typeName: Ember.computed 'typeKind.name', ->
    @get 'typeKind.name'
  shared: Ember.computed 'shared_component', ->
    (!!@get 'shared_component') or (@get('type') == 'shared')
  single: Ember.computed 'typeKind.slug',
    get: -> @get('typeKind.slug') == 'single'
    set: (key, value) ->
      @set 'type', 'single' if value?
      @get 'single'
  multi: Ember.computed 'typeKind.slug',
    get: -> @get('typeKind.slug') == 'multi'
    set: (key, value) ->
      @set 'type', 'multi' if value?
      @get 'multi'
  js: Ember.computed 'typeKind.slug',
    get: -> @get('typeKind.slug') == 'js'
    set: (key, value) ->
      @set 'type', 'js' if value?
      @get 'js'
  name: Ember.computed 'type', ->
    type = @get 'type'
    type = 'shared' if @get 'shared'
    t("types.proxy-endpoint-component.#{type}").capitalize()


# Declare available types and their human-readable names
types = 'single multi js'.split(' ').map (type) ->
  name: t "types.proxy-endpoint-component.#{type}"
  slug: type
  value: type

ActionComponent.reopenClass
  types: types

`export default ActionComponent`
