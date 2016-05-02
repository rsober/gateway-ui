`import DS from 'ember-data'`

JsonSchemaNodeSerializer = DS.JSONSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    parent:
      serialize: false
    children:
      serialize: false

  # All serializable attributes by type.
  attrsByType:
    '*': ['type', 'title', 'description']
    'object': ['properties', 'patternProperties', 'required', 'minProperties', 'maxProperties']
    'array': ['items', 'minItems', 'maxItems', 'uniqueItems']
    'number': ['multipleOf', 'minimum', 'maximum', 'exclusiveMinimum', 'exclusiveMaximum']
    'integer': ['multipleOf', 'minimum', 'maximum', 'exclusiveMinimum', 'exclusiveMaximum']
    'string': ['pattern', 'minLength', 'maxLength']

  normalize: (typeClass, hash) ->
    hash.parent ?= null
    hash.children ?= []
    @_super arguments...

  # JSON Schema attribute keys are camel case.
  keyForAttribute: (attr, method) ->
    Ember.String.camelize attr

  # Returns an object containing only attributes allowed for the type as
  # specified in `attrsByType`.  Non-allowed attributes and attributes with
  # values of `false`, `null`, or `undefined` are thrown out.
  cleanAttributes: (serialized) ->
    cleaned = {}
    allowed = Ember.copy(@get('attrsByType.*')).concat @get("attrsByType.#{serialized.type}")
    allowed.forEach (attrName) ->
      value = serialized[attrName]
      cleaned[attrName] = value if !Ember.isNone(value) and (value != false)
    delete cleaned.required if !Ember.isArray cleaned.required
    cleaned

  serialize: (snapshot, options) ->
    serialized =  @_super arguments...
    children = snapshot.hasMany 'children'
    switch serialized.type
      when 'array'
        # An array node's children go into `items`.
        serialized.items = children[0].serialize() if children.length
      when 'object'
        # An object node's children go into `properties` or `patternProperties`.
        children.forEach (child) ->
          name = child.attr 'name'
          if child.attr 'pattern_name'
            serialized.patternProperties ?= {}
            serialized.patternProperties[name] = child.serialize()
          else
            serialized.properties ?= {}
            serialized.properties[name] = child.serialize()
        serialized.required = children
          .map (child) -> child.attr('name') if child.attr 'required'
          .compact()
    @cleanAttributes serialized
>>>>>>> d6b3f2fad5dbbe2d7d063c9fae5f74eb191a76da

`export default JsonSchemaNodeSerializer`
