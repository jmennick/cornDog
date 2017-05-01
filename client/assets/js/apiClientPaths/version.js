export default (apiClient) => {
  apiClient.define('version', {
    item_type: '',
    item_id: '',
    event: '',
    whodunnit: '',
    whodunnit_name: '',
    object: '',
    object_changes: '',
    created_at: ''
  })
}
