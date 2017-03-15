export default (apiClient)=> {
  apiClient.define('ledger_entry', {
    date: '',
    description: '',
    left_amount: '',
    right_amount: '',
    balance: '',
    transaction_id: ''
  })
}
