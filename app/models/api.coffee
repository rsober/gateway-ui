`import DS from 'ember-data'`
`import Model from './model'`

Api = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  proxy_endpoints: DS.hasMany 'proxy-endpoint', async: true
  environments: DS.hasMany 'environment', async: true
  endpoint_groups: DS.hasMany 'endpoint-group', async: true
  remote_endpoints: DS.hasMany 'remote-endpoint', async: true
  hosts: DS.hasMany 'host', async: true
  libraries: DS.hasMany 'library', async: true

`export default Api`
