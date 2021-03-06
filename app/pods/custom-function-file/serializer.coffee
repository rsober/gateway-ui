`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

CustomFunctionFileSerializer = ApplicationSerializer.extend
  attrs:
    custom_function:
      serialize: false

  modelNameFromPayloadKey: (payloadKey) ->
    'custom-function-file'
  payloadKeyFromModelName: (modelName) ->
    'file'

`export default CustomFunctionFileSerializer`
