`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`
`import userScenario from 'gateway/mirage/scenarios/user'`
`import { makePostHandler } from 'gateway/mirage/helpers/route-handlers'`

module 'Acceptance: User - Create',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new users on index', (assert) ->
  done = assert.async()
  userScenario server
  authenticateSession @application
  beforeCreateCount = server.db.users.length
  after = ->
    wait()
    andThen ->
      afterCreateCount = server.db.users.length
      assert.equal afterCreateCount, beforeCreateCount + 1
      assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount + 1
      done()
  server.post '/users', makePostHandler('user', after)
  visit '/users'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/users'
    assert.equal find('.ap-table-index tbody tr').length, beforeCreateCount
  fillIn '[name=name]', 'New User'
  fillIn '[name=email]', 'user@example.net'
  click '.ap-panel-new [type=submit]'
