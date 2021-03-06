`import Ember from 'ember'`
`import BsPanelComponent from 'gateway-ui/pods/components/bs-panel/component'`

ApPanelUploadComponent = BsPanelComponent.extend
  fileReaderService: Ember.inject.service 'file-reader'
  tagName: 'label'
  classNames: ['ap-panel-upload text-center']
  classNameBindings: ['isSet:active']
  value: null
  style: 'drop'
  t: 'actions.drop-or-click-to-upload'
  isSet: Ember.computed 'value', -> !!@get('value')?.match /^data/
  'icon-after': true
  icon: Ember.computed 'isSet', ->
    'the-essentials-102' if @get 'isSet'
  readFiles: (files) ->
    if files.length
      file = files[0]
      @get('fileReaderService').readToDataURI(file).then (dataURI) =>
        @set 'value', dataURI if dataURI
  change: (e) ->
    @readFiles e.target.files
  dragOver: (e) ->
    false
  dragEnd: ->
    false
  drop: (e) ->
    e.preventDefault()
    @readFiles e.dataTransfer.files
    false

`export default ApPanelUploadComponent`
