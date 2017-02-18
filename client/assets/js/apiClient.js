import DevourClient from 'devour-client'
import apiClientPaths from './apiClientPaths'

const apiClient = new DevourClient({
  apiUrl: 'http://corndog.herokuapp.com/api'
  // apiUrl: 'http://localhost:5000/api'
})

apiClientPaths.forEach(p => p(apiClient));
export default apiClient
