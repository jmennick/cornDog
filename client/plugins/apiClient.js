import DevourClient from 'devour-client'
import apiClientPaths from '~assets/js/apiClientPaths'

const apiClient = new DevourClient({
  apiUrl: process.env.apiUrl,
  headers: {
    'Access-Control-Allow-Origin': '*'
  }
})

apiClientPaths.forEach(p => p(apiClient));
export default apiClient
