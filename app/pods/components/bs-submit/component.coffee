`import Ember from 'ember'`
`import BsButtonComponent from 'gateway-ui/pods/components/bs-button/component'`

BsSubmitComponent = BsButtonComponent.extend
  tagName: 'button'
  attributeBindings: ['type']
  type: 'submit'

`export default BsSubmitComponent`
