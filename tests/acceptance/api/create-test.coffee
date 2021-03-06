`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`
`import { makePostHandler } from 'gateway-ui/mirage/helpers/route-handlers'`

module 'Acceptance: API - Create',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new APIs on index', (assert) ->
  done = assert.async()
  server.createList 'api', 1
  authenticateSession @application
  beforeCreateCount = server.db.apis.length
  after = ->
    # navigate back to APIs index since saving an API redirects to
    # its proxy endpoints index
    Ember.run.later (->
      visit '/apis'
      andThen ->
        assert.equal currentURL(), '/apis'
        afterCreateCount = server.db.apis.length
        assert.equal afterCreateCount, beforeCreateCount + 1
        assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount + 1
        done()
      ), 3000
  server.post '/apis', makePostHandler('api', after)
  visit '/apis'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/apis'
    assert.equal find('.ap-table-auto-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New API'
  click '.ap-panel-new [type=submit]'
