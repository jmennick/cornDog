export default (apiClient) => {
  apiClient.define('journal_entry', {
    created_by: {
      jsonApi: 'hasOne',
      type: 'users'
    },
    date: '',
    items: '',
    state: '',
    description: ''
  }, {
    readOnly: ['created_by', 'state'],
    include: 'created_by'
  })
}
