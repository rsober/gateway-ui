`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

RemoteEndpointPushPlatform = Model.extend
  name: DS.attr 'string'
  codename: DS.attr 'string'
  type: DS.attr 'string', defaultValue: 'ios'
  certificate: DS.attr 'string'
  password: DS.attr 'string'
  topic: DS.attr 'string'
  development: DS.attr 'boolean', defaultValue: false
  api_key: DS.attr 'string'

  # Services
  session: Ember.inject.service()

  # Computed
  username: Ember.computed 'session.session.authenticated.email', 'apiName',
  'remoteEndpointCodename', 'codename', 'remote_endpoint', 'environment_datum', ->
    email = @get 'session.session.authenticated.email'
    apiName = @get 'apiName'
    remoteEndpointCodename = @get 'remoteEndpointCodename'
    codename = @get('codename') || ""
    remoteEndpoint = @get('remote_endpoint') || @get('environment_datum.remote_endpoint')
    if remoteEndpoint?
      apiName = remoteEndpoint.get 'api.name'
      remoteEndpointCodename = remoteEndpoint.get 'codename'
    "#{email},#{apiName},#{remoteEndpointCodename},#{codename}"

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: false

`export default RemoteEndpointPushPlatform`
