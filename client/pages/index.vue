<template>
  <div>
    <toolbar-top title="Accounts">
      <b-button slot="left" variant="theme" @click="refresh()"><icon name="refresh" :spin="isLoading"></icon> Refresh</b-button>
      <b-button slot="right" variant="theme" @click="showModal()">
        <icon name="plus"></icon> Add Account
      </b-button>
    </toolbar-top>
    <div class="content-container">
      <resource-form-modal>
        <h1>I am slotted content</h1>
      </resource-form-modal>
      <div v-if="isFailed">
        <h1>Loading Failed</h1>
        <p class="lead">{{error}}</p>
      </div>
      <table class="table table-striped no-bottom-margin" v-if="isSuccess">
        <thead>
          <tr>
            <th>Code</th>
            <th>Name</th>
            <th>Kind</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="a in accounts">
            <td>{{a.code}}</td>
            <td>{{a.name}}</td>
            <td>{{a.kind}}</td>
            <td class="d-flex justify-content-end td-actions"><div class="btn-toolbar">
              <b-button size="sm" class="mr-2"><icon name="eye"></icon></b-button>
              <b-button size="sm" class="mr-2"><icon name="edit"></icon></b-button>
              <b-button size="sm"><icon :name="activeToggleLabel(a)"></icon></b-button>
            </div></td>
          </tr>
        </tbody>
      </table>
    </div>
    <b-navbar type="inverse" variant="chrome" class="fixed-bottom d-flex flex-row align-items-center">
      <!-- <b-button variant="inverse" class="p-2">Blah</b-button> -->
      <!-- <b-button variant="chrome" class="p-2 mr-auto"><icon name="filter"></icon> Sort &amp; Filter</b-button> -->
      <b-pagination class="p-2 mr-auto no-padding" :size="paginationSize" :total-rows="100" :per-page="10" v-model="currentPage"></b-pagination>
      <!-- <b-button variant="inverse" class="p-2 ml-auto">Blah</b-button> -->
      <b-dropdown text="Reports" variant="chrome" class="p-2 ml-auto no-padding" dropup right>
        <a class="dropdown-item">First Report</a>
        <a class="dropdown-item">Second Report</a>
        <a class="dropdown-item">Third Report</a>
      </b-dropdown>
    </b-navbar>
  </div>
</template>

<script>
import {mapState, mapMutations, mapGetters} from 'vuex'
import ToolbarTop from '~components/ToolbarTop'
import ResourceFormModal from '~components/ResourceFormModal'

import {
  isLoading, isSuccess, isFailed,
  beginLoading, loadingSuccessful
} from '~store/resource'

import {showModal} from '~store/resourceForm'

export default {
  components: {
    ToolbarTop,
    ResourceFormModal
  },
  data: ()=> ({
    currentPage: 1
  }),
  async fetch({params, store}) {
    await store.dispatch('resource/fetch', 'account')
  },
  computed: {
    ...mapState({
      accounts: ({resource})=> resource.data,
      error: ({resource})=> resource.error,
      showSidebar: ({sidebar})=> sidebar.shown
    }),
    ...mapGetters('resource', {
      isLoading, isSuccess, isFailed
    }),
    paginationSize() {
      return this.showSidebar ? 'sm' : 'md'
    }
  },
  methods: {
    ...mapMutations('resource', {
      beginLoading, loadingSuccessful
    }),
    ...mapMutations('resourceForm', {
      showModal
    }),
    activeToggleLabel(account) {
      return account.active ? 'ban' : 'thumb-tack'
    },
    refresh() {
      this.$store.dispatch('resource/fetch', 'account')
    }
  }
}
</script>
