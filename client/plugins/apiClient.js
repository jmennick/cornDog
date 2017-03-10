import DevourClient from 'devour-client'
import apiClientPaths from '~assets/js/apiClientPaths'

const apiClient = new DevourClient({
  apiUrl: process.env.apiUrl,
  headers: {
    'Access-Control-Allow-Origin': '*'
  }
})

apiClient.replaceMiddleware('errors', {
  name: 'handle-errors',
  error: (payload)=> payload.data
})

apiClientPaths.forEach(p => p(apiClient));
export default apiClient
