`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`
`import HttpRemoteEndpointSerializer from './remote-endpoint/http'`
`import SoapRemoteEndpointSerializer from './remote-endpoint/soap'`
`import SqlserverRemoteEndpointSerializer from './remote-endpoint/sqlserver'`
`import PostgresRemoteEndpointSerializer from './remote-endpoint/postgres'`
`import MysqlRemoteEndpointSerializer from './remote-endpoint/mysql'`
`import MongodbRemoteEndpointSerializer from './remote-endpoint/mongodb'`
`import ScriptRemoteEndpointSerializer from './remote-endpoint/script'`

RemoteEndpointLikeSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      serialize: false
      deserialize: 'records'
    query:
      serialize: false
      deserialize: 'records'
    hosts:
      embedded: 'always'
    environment_data:
      embedded: 'always'

  # Normalization
  normalize: (type, hash, property) ->
    hash.data ?= {}
    # normalize embedded resources
    @normalizeEnvironmentData hash
    Ember.merge hash,
      headers: @objectToArray hash.data.headers
      query: @objectToArray hash.data.query
      hosts: hash.data.config?.hosts or []
    # normalize attributes
    switch hash.type
      when 'http' then HttpRemoteEndpointSerializer.normalize hash
      when 'soap' then SoapRemoteEndpointSerializer.normalize hash
      when 'sqlserver' then SqlserverRemoteEndpointSerializer.normalize hash
      when 'postgres' then PostgresRemoteEndpointSerializer.normalize hash
      when 'mysql' then MysqlRemoteEndpointSerializer.normalize hash
      when 'mongodb' then MongodbRemoteEndpointSerializer.normalize hash
      when 'script' then ScriptRemoteEndpointSerializer.normalize hash
    @_super.apply @, arguments
  normalizeEnvironmentData: (hash) ->
    hash.environment_data ?= []
    datum.type = hash.type for datum in hash.environment_data
  objectToArray: (obj={}) ->
    for key, value of obj
      name: key
      value: value

  # Serialization
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    # serialize embedded records
    serialized.data ?= {}
    Ember.merge serialized.data,
      headers: @serializeHeaders model
      query: @serializeQuery model
    # serialize attributes
    switch serialized.type
      when 'http' then HttpRemoteEndpointSerializer.serialize serialized
      when 'soap' then SoapRemoteEndpointSerializer.serialize serialized
      when 'sqlserver'
        SqlserverRemoteEndpointSerializer.serialize serialized
      when 'postgres' then PostgresRemoteEndpointSerializer.serialize serialized
      when 'mysql' then MysqlRemoteEndpointSerializer.serialize serialized
      when 'mongodb' then MongodbRemoteEndpointSerializer.serialize serialized
      when 'script' then ScriptRemoteEndpointSerializer.serialize serialized
    serialized
  serializeHeaders: (model) ->
    headers = {}
    model.get('headers').forEach (header) ->
      headers[header.get 'name'] = header.get 'value'
    headers
  serializeQuery: (model) ->
    query = {}
    model.get('query').forEach (param) ->
      query[param.get 'name'] = param.get 'value'
    query

`export default RemoteEndpointLikeSerializer`
