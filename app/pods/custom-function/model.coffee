`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`

CustomFunction = Model.extend
  name: DS.attr 'string'
  language: DS.attr 'string'
  description: DS.attr 'string'
  active: DS.attr 'boolean'

  # Relationships
  api: DS.belongsTo 'api', async: true
  files: DS.hasMany 'custom-function-file', async: true

languages = 'java node c# python'.split(' ').map (language) ->
  name: t "custom-function-languages.#{language}"
  slug: language
  value: language

CustomFunction.reopenClass
  languages: languages

`export default CustomFunction`
