export default (apiClient)=> {
  apiClient.define('journal_entry', {
    created_by: {
      jsonApi: 'hasOne',
      type: 'users'
    },
    date: '',
    items: ''
  }, {
    readOnly: ['created_by'],
    include: 'created_by'
  })
}
