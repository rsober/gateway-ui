`import WebSocketMockServer from 'gateway-ui/helpers/websocket-mock-server'`
`import config from  'gateway-ui/config/environment'`

MockNotificationsInitializer =
  name: 'mock-notifications'

  getHeartbeatInterval: ->
    intervalString = config.APP.wsHeartbeatInterval?.toString()
    parseInt(intervalString, 10) * 1000

  # TODO
  # buildSocketURL and cleanURL are duplicate methods found in the notification
  # and application adapters.  It's unclear how to lookup an adapter from within
  # an initializer.
  #
  # Ideally, we'd just lookup the notification adapter and call buildSocketURL.
  buildSocketURL: (type) ->
    url = "#{config.api.url}/#{type}"
    isSecure = (location.protocol is 'https:') or (url.match /^https:\/\//)
    url = url.replace /^[a-z]*:\/\//, '' # remove protocol
    url = "#{location.host}#{url}" if !config.api.host
    protocol = if isSecure then 'wss:' else 'ws:'
    url = "#{protocol}//#{url}"
    # replace double leading slash with single
    url = @cleanURL url
    url
  cleanURL: (url) ->
    leadingProtocol = /^(http|ws)s?\:\/{2}/
    multiSlashes = /\/{2,}/g
    # if this is a relative path (because no host was specified),
    # then add an initial slash to make the path absolute
    url = "/#{url}" if !url.match leadingProtocol
    # if protocol is included,
    hasProtocol = url.match leadingProtocol
    if hasProtocol
      protocol = hasProtocol[0]
      remaining = url.replace(protocol, '').replace multiSlashes, '/'
    else
      protocol = ''
      remaining = url.replace multiSlashes, '/'
    url = "#{protocol}#{remaining}"
    url

  initialize: (app) ->
    if app.mockNotifications and app.mockNotificationInterval
      url = @buildSocketURL 'notifications'
      heartbeatInterval = @getHeartbeatInterval()
      new WebSocketMockServer url, (server) ->
        server.open()
        setInterval (->
          Ember.run.next ->
            server.message 'heartbeat'
          ), heartbeatInterval
        setInterval (->
          Ember.run.next ->
            server.message JSON.stringify
              resource: 'api'
              resource_id: 1
              api_id: 1
              action: 'update'
              user: 'developer@software.com'
          ), app.mockNotificationInterval

`export default MockNotificationsInitializer`
