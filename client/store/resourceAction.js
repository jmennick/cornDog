import {titleize} from 'inflection'
import {post} from 'axios'

export const VIEW_STATE_HIDDEN = 'hidden'
export const VIEW_STATE_SHOWN = 'shown'
export const VIEW_STATE_EXECUTING = 'executing'
export const VIEW_STATE_ERROR = 'error'
export const VIEW_STATE_SUCCESS = 'success'

export const state = {
  viewState: VIEW_STATE_HIDDEN,
  name: '',
  data: null,
  error: null,
  result: null,
  confirmCustomName: null,
  confirmCustomIcon: null,
  confirmCustomColor: null,
  refreshOnSuccess: true
}

export const showAction = 'showAction'
export const beginExecuting = 'beginExecuting'
export const executionError = 'executionError'
export const executeSuccessful = 'executeSuccessful'
export const cancelAction = 'cancelAction'
export const saveData = 'saveData'

export const mutations = {
  [showAction] (state, {name, data = {}, confirmName = null, confirmIcon = null, confirmColor = null, refreshOnSuccess = true}) {
    let _data = {}; Object.assign(_data, data)
    state.viewState = VIEW_STATE_SHOWN
    state.data = _data
    state.name = name
    state.confirmCustomName = confirmName
    state.confirmCustomIcon = confirmIcon
    state.confirmCustomColor = confirmColor
    state.refreshOnSuccess = refreshOnSuccess
  },
  [beginExecuting] (state) {
    state.viewState = VIEW_STATE_EXECUTING
  },
  [executionError] (state, error) {
    state.viewState = VIEW_STATE_ERROR
    state.error = error
  },
  [executeSuccessful] (state, result) {
    state.viewState = VIEW_STATE_SUCCESS
    state.result = result
  },
  [cancelAction] (state) {
    state.viewState = VIEW_STATE_HIDDEN
  },
  [saveData] (state, data) {
    state.data = data
  }
}

export const viewStateIsShown = 'viewStateIsShown'
export const viewStateIsExecuting = 'viewStateIsExecuting'
export const viewStateIsError = 'viewStateIsError'
export const viewStateIsSuccess = 'viewStateIsSuccess'
export const viewStateIsHidden = 'viewStateIsHidden'
export const modalShown = 'modalShown'
export const humanActionName = 'humanActionName'
export const confirmName = 'confirmName'
export const confirmIcon = 'confirmIcon'
export const confirmColor = 'confirmColor'

export const getters = {
  [viewStateIsShown]: ({viewState}) => viewState === VIEW_STATE_SHOWN,
  [viewStateIsExecuting]: ({viewState}) => viewState === VIEW_STATE_EXECUTING,
  [viewStateIsError]: ({viewState}) => viewState === VIEW_STATE_ERROR,
  [viewStateIsSuccess]: ({viewState}) => viewState === VIEW_STATE_SUCCESS,
  [viewStateIsHidden]: ({viewState}) => viewState === VIEW_STATE_HIDDEN,
  [modalShown]: ({viewState}) => (viewState !== VIEW_STATE_HIDDEN) && (viewState !== VIEW_STATE_SUCCESS),
  [humanActionName]: ({name}) => titleize(name),
  [confirmName]: ({confirmCustomName}, {humanActionName}) => confirmCustomName || humanActionName,
  [confirmIcon]: ({confirmCustomIcon}) => confirmCustomIcon,
  [confirmColor]: ({confirmCustomColor}) => confirmCustomColor || 'primary'
}

export const execute = 'execute'

export const actions = {
  [execute]: async ({commit, state}) => {
    commit(beginExecuting)
    try {
      let correctStorage
      if (typeof (Storage) !== 'undefined') {
        correctStorage = localStorage
      } else {
        correctStorage = sessionStorage
      }
      const authToken = correctStorage.getItem('authToken')
      const url = `${process.env.apiUrl}/actions/${state.name}`
      const {data} = await post(url, state.data, {
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Authorization': `Bearer ${authToken}`
        }
      })
      commit(executeSuccessful, data)
    } catch (err) {
      commit(executionError, err.toString())
    }
  }
}
