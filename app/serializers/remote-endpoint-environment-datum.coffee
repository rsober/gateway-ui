`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from 'gateway/serializers/remote-endpoint-like'`

RemoteEndpointEnvironmentDatumSerializer = RemoteEndpointLikeSerializer.extend
  attrs:
    remote_endpoint:
      serialize: false

`export default RemoteEndpointEnvironmentDatumSerializer`
