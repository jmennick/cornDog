
export const state = {
  selectedPage: 1
}

export const selectPage = 'selectPage'

export const mutations = {
  [selectPage] (state, page) {
    state.selectedPage = page
  }
}
