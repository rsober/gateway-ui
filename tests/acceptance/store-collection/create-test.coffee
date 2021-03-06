`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway-ui/tests/helpers/start-app'`
`import destroyApp from 'gateway-ui/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway-ui/tests/helpers/ember-simple-auth'`

module 'Acceptance: Store Collection - Create',
  beforeEach: ->
    @application = startApp()
    collections = server.createList 'store_collection', 3
    collections.forEach (collection) ->
      id = collection.id
      server.createList 'store_object', 3, storeCollectionId: id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can create new store collections', (assert) ->
  beforeCreateCount = server.db.storeCollections.length
  visit '/manage/collections/1/objects'
  andThen ->
    assert.equal beforeCreateCount > 0, true
    assert.equal currentURL(), '/manage/collections/1/objects'
    assert.equal find('.ap-app-secondary:eq(1) .ap-app-secondary-sidebar li:not([data-t="actions.new"])').length, beforeCreateCount
  click '.ap-app-secondary:eq(1) .ap-app-secondary-sidebar li[data-t="actions.new"] a'
  fillIn '[name=name]', 'New Collection'
  click '[type=submit]'
  andThen ->
    assert.equal server.db.storeCollections.length, beforeCreateCount + 1
    assert.equal find('.ap-app-secondary:eq(1) .ap-app-secondary-sidebar li:not([data-t="actions.new"])').length, beforeCreateCount + 1
