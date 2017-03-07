export default (apiClient)=> {
  apiClient.define('account', {
    name: '',
    code: '',
    order: '',
    active: '',
    description: '',
    created_by: {
      jsonApi: 'hasOne',
      type: 'users'
    },
    created_at: '',
    kind: '',
    kind_human: '',
    initial_balance: ''
  }, {
    readOnly: ['kind_human', 'created_at', 'created_by'],
    include: 'created_by'
  })
}
