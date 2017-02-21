export default (apiClient)=> {
  apiClient.define('account', {
    name: '',
    code: '',
    order: '',
    active: '',
    description: '',
    created_by_id: '',
    kind: '',
    kind_human: '',
    initial_balance: ''
  }, {
    readOnly: ['kind_human']
  })
}
