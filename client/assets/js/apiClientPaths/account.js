export default (apiClient)=> {
  apiClient.define('account', {
    name: '',
    code: '',
    order: '',
    active: '',
    description: '',
    createdById: '',
    kind: ''
  })
}
