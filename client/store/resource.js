import apiClient from '~plugins/apiClient'
import {titleize, pluralize, tableize} from 'inflection'
import {result} from 'underscore'
import {defaultTo, isNull} from 'lodash'

export const VIEW_STATE_LOADING = 'loading'
export const VIEW_STATE_SUCCESS = 'success'
export const VIEW_STATE_FAILED = 'failed'

export const state = {
  viewState: null,
  data: [],
  meta: null,
  selected: null,
  selectedId: null,
  error: null,
  name: null,
  baseName: null,
  baseId: null,
  title: '',
  query: {},
  newResource: {},
  showRouteArticle: null,
  listRouteName: null,
  showRouteBase: null,
  backButtonTitle: null
}

export const beginLoading = 'beginLoading'
export const loadingSuccessful = 'loadingSuccessful'
export const loadingFailed = 'loadingFailed'
export const resourceSetup = 'resourceSetup'

export const mutations = {
  [beginLoading](state) {
    state.viewState = VIEW_STATE_LOADING
  },
  [loadingSuccessful](state, data) {
    state.viewState = VIEW_STATE_SUCCESS
    if (state.selectedId == null) {
      state.data = data
    } else {
      state.selected = data
    }
    state.meta = data.meta
  },
  [loadingFailed](state, error) {
    state.viewState = VIEW_STATE_FAILED
    state.error = error
  },
  [resourceSetup](state, {name, id=null, baseName=null, baseId=null, query={}, newResource={}, title=null, showRouteArticle=null, listRouteName=null, showRouteBase=null, backButtonTitle=null}) {
    state.name = name
    state.data = []
    state.selectedId = id
    state.baseName = baseName
    state.baseId = baseId
    state.query = query
    state.newResource = newResource
    state.showRouteArticle = defaultTo(showRouteArticle, 'id')
    state.listRouteName = defaultTo(listRouteName, pluralize(tableize(name)))
    state.showRouteBase = defaultTo(showRouteBase, state.listRouteName)
    state.backButtonTitle = defaultTo(backButtonTitle, titleize(state.listRouteName))

    const defaultTitle = isNull(id) ? pluralize(titleize(name)) : titleize(name)
    state.title = defaultTo(title, defaultTitle)
  }
}

export const isLoading = 'isLoading'
export const isSuccess = 'isSuccess'
export const isFailed = 'isFailed'
export const labelSingular = 'labelSingular'
export const labelPlural = 'labelPlural'
export const currentUser = 'currentUser'
export const showRouteName = 'showRouteName'
export const showRoute = 'showRoute'
export const listRoute = 'listRoute'

export const getters = {
  [isLoading]: ({viewState})=> viewState == VIEW_STATE_LOADING,
  [isSuccess]: ({viewState})=> viewState == VIEW_STATE_SUCCESS,
  [isFailed]: ({viewState})=> viewState == VIEW_STATE_FAILED,
  [labelSingular]: ({name})=> titleize(name),
  [labelPlural]: ({name})=> pluralize(titleize(name)),
  [currentUser]: ({meta})=> result(meta, 'current_user', {
    name: '???',
    email: '???',
    role: 'no_access'
  }),
  [showRouteName]: ({showRouteBase, showRouteArticle})=> {
    return `${showRouteBase}${showRouteBase.length?'-':''}${showRouteArticle}`
  },
  [showRoute]: ({showRouteArticle, selectedId}, {showRouteName})=> ({
    name: showRouteName,
    params: {[showRouteArticle]: selectedId}
  }),
  [listRoute]: ({listRouteName})=> {
    return {
      name: listRouteName
    }
  }
}

export const setup = 'setup'
export const fetch = 'fetch'

export const actions = {
  [setup]: async({commit, dispatch}, {name, id=null, baseName=null, baseId=null, query={}, newResource={}, title=null, showRouteArticle=null, listRouteName=null, showRouteBase=null, backButtonTitle=null})=> {
    commit(resourceSetup, {name, id, baseName, baseId, query, newResource, title, showRouteArticle, listRouteName, showRouteBase, backButtonTitle})
    await dispatch(fetch)
  },
  [fetch]: async ({commit, state})=> {
    commit(beginLoading)
    try {
      let correctStorage
      if (typeof(Storage) !== "undefined") {
        correctStorage = localStorage
      } else {
        correctStorage = sessionStorage
      }
      const authToken = correctStorage.getItem('authToken')
      apiClient.headers['Authorization'] = `Bearer ${authToken}`

      if (state.selectedId == null) {
        if (state.baseName == null) {
          const data = await apiClient.findAll(state.name, state.query)
          commit(loadingSuccessful, data)
        } else {
          console.log('base:', state.baseName, state.baseId)
          const data = await apiClient.one(state.baseName, state.baseId).all(state.name).get(state.query)
          commit(loadingSuccessful, data)
        }
      } else {
        const data = await apiClient.find(state.name, state.selectedId, state.query)
        commit(loadingSuccessful, data)
      }
    } catch(err) {
      commit(loadingFailed, err)
    }
  }
}
