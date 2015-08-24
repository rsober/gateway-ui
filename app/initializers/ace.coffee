# TODO
# when mysql is allowed, re-add:
# AP.MySQL.Request
words = '''
request
response
AP.HTTP.Request
AP.HTTP.Response
method
uri
path
body
headers
form
query
vars
params
statusCode
body
headers
env
log
session
url
setFormBody
AP.SQLServer.Request
AP.Postgres.Request
AP.Mongo.Request
ObjectId
'''.split /\n/

initialize = (container, app) ->
  config = window.ace.require 'ace/config'
  langTools = window.ace.require 'ace/ext/language_tools'
  completer =
    getCompletions: (editor, session, pos, prefix, callback) ->
      if session.$modeId is 'ace/mode/javascript'
        matches = []
        if prefix.length
          for word in words
            # high score for matches at the beginning of a word
            if word.toLowerCase().indexOf(prefix.toLowerCase()) == 0
              matches.push
                caption: word
                value: word
                meta: 'Gateway'
            # low score for matches at the beginning of a word
            else if word.toLowerCase().indexOf(prefix.toLowerCase()) > 0
              matches.push
                caption: word
                value: word
                meta: 'Gateway'
        callback null, matches
  langTools.addCompleter completer

AceInitializer =
  name: 'ace'
  initialize: initialize

`export {initialize}`
`export default AceInitializer`
