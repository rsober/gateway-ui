`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from 'gateway/pods/remote-endpoint-like/serializer'`

RemoteEndpointSerializer = RemoteEndpointLikeSerializer.extend
  attrs:
    api:
      serialize: false
    environment_data:
      embedded: 'always'

`export default RemoteEndpointSerializer`
