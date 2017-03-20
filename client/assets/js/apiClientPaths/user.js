export default (apiClient)=> {
  apiClient.define('user', {
    name: '',
    email: '',
    role: '',
    password: ''
  })
}
