`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'gateway/tests/helpers/start-app'`
`import destroyApp from 'gateway/tests/helpers/destroy-app'`
`import { currentSession, authenticateSession, invalidateSession } from 'gateway/tests/helpers/ember-simple-auth'`

module 'Acceptance: Job Test - Delete',
  beforeEach: ->
    @application = startApp()
    server.createList('api', 1).forEach (api) ->
      server.createList 'environment', 3, apiId: api.id
      server.createList 'endpoint_group', 5, apiId: api.id
      server.createList 'remote_endpoint', 20, apiId: api.id
      server.createList('job', 1, apiId: api.id).forEach (j) ->
        server.createList 'job_test', 3, jobId: j.id
    authenticateSession @application
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    return

  afterEach: -> destroyApp @application

test 'user can delete from index', (assert) ->
  visit '/apis/1/jobs/1/tests'
  andThen ->
    count = server.schema.job.all()[0].job_tests.length
    assert.equal currentURL(), '/apis/1/jobs/1/tests'
    assert.equal count, 3
    assert.equal find('.ap-table-index tbody tr').length, 3
  click '.ap-table-index tbody tr:eq(0) [data-t="actions.delete"] a'
  andThen ->
    count = server.schema.job.all()[0].job_tests.length
    assert.equal currentURL(), '/apis/1/jobs/1/tests'
    assert.equal count, 2
    assert.equal find('.ap-table-index tbody tr').length, 2

test 'user can delete from edit', (assert) ->
  visit '/apis/1/jobs/1/tests/1/edit'
  andThen ->
    count = server.schema.job.all()[0].job_tests.length
    assert.equal currentURL(), '/apis/1/jobs/1/tests/1/edit'
    assert.equal count, 3
  click 'a[data-t="actions.delete"]'
  andThen ->
    count = server.schema.job.all()[0].job_tests.length
    assert.equal currentURL(), '/apis/1/jobs/1/tests'
    assert.equal count, 2
    assert.equal find('.ap-table-index tbody tr').length, 2