import DevourClient from 'devour-client'
import apiClientPaths from '~assets/js/apiClientPaths'

const apiClient = new DevourClient({
  apiUrl: `${process.env.apiUrl}/api`,
  headers: {
    'Access-Control-Allow-Origin': '*'
  }
})

apiClient.replaceMiddleware('errors', {
  name: 'handle-errors',
  error: (payload)=> payload.data
})

// apiClient.insertMiddlewareAfter('HEADER', {
//   name: 'JWT Auth',
//   req: (payload)=> {
//     return payload
//   }
// })

apiClientPaths.forEach(p => p(apiClient));
export default apiClient
