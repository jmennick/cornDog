import apiClient from '~plugins/apiClient'

export const VIEW_STATE_HIDDEN = 'hidden'
export const VIEW_STATE_SHOWN = 'shown'
export const VIEW_STATE_SAVING = 'saving'
export const VIEW_STATE_ERROR = 'error'
export const VIEW_STATE_SUCCESS = 'success'

export const state = {
  viewState: VIEW_STATE_HIDDEN,
  modalData: null,
  error: null,
  resultData: null
}

export const showModal = 'showModal'
export const beginSaving = 'beginSaving'
export const saveError = 'saveError'
export const saveSuccessful = 'saveSuccessful'
export const closeModal = 'closeModal'
export const saveData = 'saveData'

export const mutations = {
  [showModal](state, data) {
    let _data = {}; Object.assign(_data, data)
    state.viewState = VIEW_STATE_SHOWN
    state.modalData = _data
  },
  [beginSaving](state) {
    state.viewState = VIEW_STATE_SAVING
  },
  [saveError](state, error) {
    state.viewState = VIEW_STATE_ERROR
    state.error = error.toString()
  },
  [saveData](state, data) {
    state.modalData = data
  },
  [saveSuccessful](state, data) {
    state.viewState = VIEW_STATE_SUCCESS
    state.resultData = data
  },
  [closeModal](state) {
    state.viewState = VIEW_STATE_HIDDEN
    state.resultData = null
  }
}

export const viewStateIsShown = 'viewStateIsShown'
export const viewStateIsSaving = 'viewStateIsSaving'
export const viewStateIsError = 'viewStateIsError'
export const viewStateIsSuccess = 'viewStateIsSuccess'
export const viewStateIsHidden = 'viewStateIsHidden'
export const modalShown = 'modalShown'

export const getters = {
  [viewStateIsShown]: ({viewState})=> viewState == VIEW_STATE_SHOWN,
  [viewStateIsSaving]: ({viewState})=> viewState == VIEW_STATE_SAVING,
  [viewStateIsError]: ({viewState})=> viewState == VIEW_STATE_ERROR,
  [viewStateIsSuccess]: ({viewState})=> viewState == VIEW_STATE_SUCCESS,
  [viewStateIsHidden]: ({viewState})=> viewState == VIEW_STATE_HIDDEN,
  [modalShown]: ({viewState})=> (viewState != VIEW_STATE_HIDDEN) && (viewState != VIEW_STATE_SUCCESS)
}

export const save = 'save'

export const actions = {
  [save]: async ({commit, state}, resourceName)=> {
    commit(beginSaving)
    try {
      let data
      if (state.modalData.id == null) {
        data = await apiClient.create(resourceName, state.modalData)
      } else {
        data = await apiClient.update(resourceName, state.modalData)
      }
      commit(saveSuccessful, data)
    } catch(err) {
      commit(saveError, err)
    }
  }
}
