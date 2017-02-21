import DevourClient from 'devour-client'
import apiClientPaths from './apiClientPaths'

const apiClient = new DevourClient({
  apiUrl: 'https://corndog.herokuapp.com/api',
  // apiUrl: 'http://localhost:5000/api',
  headers: {
    'Access-Control-Allow-Origin': '*'
  }
})

apiClient.headers['Access-Control-Allow-Origin'] = '*'

apiClientPaths.forEach(p => p(apiClient));
export default apiClient
