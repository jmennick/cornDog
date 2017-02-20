import apiClient from '~assets/js/apiClient'

export const VIEW_STATE_LOADING = 'loading'
export const VIEW_STATE_SUCCESS = 'success'
export const VIEW_STATE_FAILED = 'failed'

export const state = {
  viewState: null,
  data: null,
  error: null
}

export const beginLoading = 'beginLoading'
export const loadingSuccessful = 'loadingSuccessful'
export const loadingFailed = 'loadingFailed'

export const mutations = {
  [beginLoading](state) {
    state.viewState = VIEW_STATE_LOADING
  },
  [loadingSuccessful](state, data) {
    state.viewState = VIEW_STATE_SUCCESS
    state.data = data
    state.meta = data.meta
  },
  [loadingFailed](state, error) {
    state.viewState = VIEW_STATE_FAILED
    state.error = error
  }
}

export const isLoading = 'isLoading'
export const isSuccess = 'isSuccess'
export const isFailed = 'isFailed'

export const getters = {
  [isLoading]: ({viewState})=> viewState == VIEW_STATE_LOADING,
  [isSuccess]: ({viewState})=> viewState == VIEW_STATE_SUCCESS,
  [isFailed]: ({viewState})=> viewState == VIEW_STATE_FAILED
}

export const fetch = 'fetch'

export const actions = {
  [fetch]: async ({commit}, resourceName)=> {
    commit(beginLoading)
    try {
      const data = await apiClient.findAll(resourceName)
      commit(loadingSuccessful, data)
    } catch(err) {
      commit(loadingFailed, err.toString())
    }
  }
}
