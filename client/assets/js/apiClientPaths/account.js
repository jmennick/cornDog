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
    initial_balance: '',
    ledger_balance: '',
    ledger_entries: {
      jsonApi: 'hasMany',
      type: 'ledger_entries'
    }
  }, {
    readOnly: ['kind_human', 'created_at', 'created_by', 'ledger_balance'],
    include: ['created_by', 'ledger_entries']
  })
}
