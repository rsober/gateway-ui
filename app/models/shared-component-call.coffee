`import DS from 'ember-data'`
`import Model from './model'`

SharedComponentCall = Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint',
    async: false
    stains: true
  before: DS.hasMany 'shared-component-transformation',
    async: false
    stains: true
    embedded: true
  after: DS.hasMany 'shared-component-transformation',
    async: false
    stains: true
    embedded: true
  shared_component: DS.belongsTo 'shared-component',
    async: false

`export default SharedComponentCall`