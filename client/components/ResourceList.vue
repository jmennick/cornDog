<template>
  <div>
    <toolbar-top :title="resourceLabelPlural">
      <resource-refresh-btn slot="left" :resource="resource"/>
      <resource-add-btn slot="right" :resource-name="resourceLabelSingular"/>
    </toolbar-top>
    <div class="content-container">
      <resource-form-modal>
        <h1>I am slotted content</h1>
      </resource-form-modal>
      <div v-if="isLoading">
        Loading...
      </div>
      <resource-loading-failed v-if="isFailed"/>
      <slot v-if="isSuccess"></slot>
    </div>
    <b-navbar type="inverse" variant="chrome" class="fixed-bottom d-flex flex-row align-items-center">
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
import {mapState, mapGetters} from 'vuex'
import ToolbarTop from '~components/ToolbarTop'
import ResourceFormModal from '~components/ResourceFormModal'
import ResourceRefreshBtn from '~components/ResourceRefreshBtn'
import ResourceAddBtn from '~components/ResourceAddBtn'
import {isSuccess, isFailed, isLoading} from '~store/resource'

export default {
  props: {
    resource: {
      type: String,
      required: true
    },
    resourceLabelSingular: {
      type: String,
      required: true
    },
    resourceLabelPlural: {
      type: String,
      required: true
    }
  },
  components: {
    ToolbarTop,
    ResourceFormModal,
    ResourceRefreshBtn,
    ResourceAddBtn
  },
  data: ()=> ({
    currentPage: 1
  }),
  computed: {
    paginationSize() {
      return this.showSidebar ? 'sm' : 'md'
    },
    ...mapState({
      error: ({resource})=> resource.error,
      showSidebar: ({sidebar})=> sidebar.shown
    }),
    ...mapGetters('resource', {
      isSuccess,
      isFailed,
      isLoading
    })
  }
}
</script>
