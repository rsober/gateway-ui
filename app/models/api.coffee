`import DS from 'ember-data'`

Api = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  environments: DS.hasMany 'environment', async: true

`export default Api`
