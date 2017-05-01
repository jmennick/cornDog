import axios from 'axios'

const correctStorage = () => {
  if (typeof (Storage) !== 'undefined') {
    return localStorage
  } else {
    return sessionStorage
  }
}
const storageGet = (key) => {
  if (process.BROWSER_BUILD) {
    return correctStorage().getItem(key)
  }
}
const storageSet = (key, value) => {
  correctStorage().setItem(key, value)
}
const storageRemove = (key) => {
  correctStorage().removeItem(key)
}

export const VIEW_STATE_AUTHENTICATING = 'authenticating'
export const VIEW_STATE_FAILED = 'failed'

export const state = {
  authToken: null,
  viewState: null,
  error: null
}

export const setAuthToken = 'setAuthToken'
export const authInProgress = 'authInProgress'
export const authFailed = 'authFailed'

export const mutations = {
  [setAuthToken] (store, authToken) {
    store.viewState = null
    store.authToken = authToken
  },
  [authInProgress] (store) {
    store.viewState = VIEW_STATE_AUTHENTICATING
  },
  [authFailed] (store, error) {
    store.viewState = VIEW_STATE_FAILED
    store.error = error
  }
}

export const isIdle = 'isIdle'
export const isAuthenticating = 'isAuthenticating'
export const isFailed = 'isFailed'
export const isAuthenticated = 'isAuthenticated'

export const getters = {
  [isIdle]: ({viewState}) => viewState === null,
  [isAuthenticating]: ({viewState}) => viewState === VIEW_STATE_AUTHENTICATING,
  [isFailed]: ({viewState}) => viewState === VIEW_STATE_FAILED,
  [isAuthenticated]: ({authToken}) => authToken !== null
}

export const refreshAuthState = 'refreshAuthState'
export const authenticate = 'authenticate'
export const storeToken = 'storeToken'
export const logOut = 'logOut'

export const actions = {
  [refreshAuthState] ({commit}) {
    const token = storageGet('authToken')
    commit(setAuthToken, token)
  },
  [authenticate]: async ({dispatch, commit}, {email, password}) => {
    try {
      const response = await axios.post(`${process.env.apiUrl}/user_token`, {
        auth: { email, password }
      })
      dispatch(storeToken, response.data.jwt)
    } catch (err) {
      commit(authFailed, err)
    }
  },
  [storeToken] ({commit}, token) {
    storageSet('authToken', token)
    commit(setAuthToken, token)
  },
  [logOut] ({commit}) {
    storageRemove('authToken')
    commit(setAuthToken, null)
  }
}
