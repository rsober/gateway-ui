`import FormController from 'gateway/controllers/form'`
`import ProxyEndpointTest from '../../models/proxy-endpoint-test'`
`import t from '../../helpers/i18n'`

# Field Rules
#
# content_type shows if:
# method is POST or PUT
#
# content_type resets to null or empty when (model-level enforcement):
# method is GET or DELETE
#
# body shows when:
# method is POST or PUT and content-type is not 'application/x-www-form-urlencoded'
#
# headers show when:
# always
#
# query params show if:
# the method is GET
# or the method is POST or PUT and content type is 'application/x-www-form-urlencoded'

ProxyEndpointTestFormController = FormController.extend
  needs: ['proxy-endpoint', 'proxy-endpoint-tests']
  modelType: 'proxy-endpoint-test'

  'option-groups': Ember.computed 'controllers.proxy-endpoint.routes.@each', ->
    method: ProxyEndpointTest.methods
    route: @get('controllers.proxy-endpoint.routes').map (route) ->
      name: route.get 'name'
      value: route.get 'path'
    content_type: ProxyEndpointTest.contentTypes

  defaultFields: Ember.computed 'controllers.proxy-endpoint.routes.@each', ->
    [
      name: 'name'
      required: true
    ,
      name: 'method'
      required: true
      type: 'select'
    ,
      name: 'route'
      label: 'resources.proxy-endpoint-route'
      required: true
      type: 'select'
    ]
  methodFields:
    'POST': [
      name: 'content_type'
      type: 'select'
      help: "fields.help.content-type"
    ]
    'PUT': [
      name: 'content_type'
      type: 'select'
      help: "fields.help.content-type"
    ]
  fields: Ember.computed 'isNew', 'method', 'methodFields', ->
    fields = @_super.apply @, arguments
    methodFields = @get "methodFields.#{@get 'method'}"
    fields = Ember.copy(fields).pushObjects methodFields if methodFields
    fields

  hasContentTypeHeader: Ember.computed 'headers.@each.name', ->
    !!@get('headers').findBy 'name', 'Content-Type'

  defaultContentType: Ember.observer 'method', 'content_type', 'hasContentTypeHeader', ->
    if !@get 'hasContentTypeHeader'
      method = @get 'method'
      contentType = @get 'content_type'
      @set 'content_type', 'application/json' if !contentType and ((method is 'POST') or (method is 'PUT'))

  bodyLanguage: Ember.computed 'content_type', ->
    language = 'text' if !@get 'isFormEncoded'
    language = 'json' if @get 'isJson'
    language = 'xml' if @get 'isXml'
    language

  bodyField: Ember.computed 'bodyLanguage', ->
    name: 'body'
    type: "editor-#{@get 'bodyLanguage'}"

  showBodyField: Ember.computed 'method', 'isFormEncoded', ->
    method = @get 'method'
    isFormEncoded = @get 'isFormEncoded'
    ((method is 'POST') or (method is 'PUT')) and !isFormEncoded

  showQueryParameters: Ember.computed 'method', 'isFormEncoded', ->
    method = @get 'method'
    (method is 'GET') or (@get('isFormEncoded') and ((method is 'POST') or (method is 'PUT')))

  createNewHeaderModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'proxy-endpoint-test-header'
    model.get('headers').pushObject newModel
  createNewQueryParameterModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'proxy-endpoint-test-query-parameter'
    model.get('query').pushObject newModel
  actions:
    'delete-proxy-endpoint-test-header': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-header': -> @createNewHeaderModel()
    'delete-proxy-endpoint-test-query-parameter': (record) -> record.deleteRecord()
    'new-proxy-endpoint-test-query-parameter': -> @createNewQueryParameterModel()
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        tests = @get 'controllers.proxy-endpoint-tests.model'
        tests.pushObject model

`export default ProxyEndpointTestFormController`