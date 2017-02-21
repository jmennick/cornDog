<template>
  <div>
    <toolbar-top :title="resourceLabelPlural">
      <resource-refresh-btn slot="left" :resource="resource"/>
      <resource-add-btn slot="right" v-if="!noAdd" :resource-name="resourceLabelSingular" :new-resource="newResource"/>
    </toolbar-top>
    <div class="content-container">
      <b-alert state="success" :show="successAlert">
        <button type="button" class="close" aria-label="Close" @click="successAlert = false">
          <span aria-hidden="true">&times;</span>
        </button>
        <strong>Loading Successful!</strong>
      </b-alert>
      <resource-form-modal :title="resourceFormTitle" :resource="resource">
        <slot name="form"></slot>
      </resource-form-modal>
      <div v-if="isLoading">
        Loading...
      </div>
      <resource-loading-failed v-if="isFailed"/>
      <slot v-if="isSuccess"></slot>
    </div>
    <b-navbar type="inverse" variant="chrome" class="fixed-bottom d-flex flex-row align-items-center">
      <!-- <b-pagination class="p-2 mr-auto no-padding" :size="paginationSize" :total-rows="100" :per-page="10" v-model="currentPage"></b-pagination> -->
      <!-- <b-button variant="inverse" class="p-2 ml-auto">Blah</b-button> -->
      <!-- <b-dropdown text="Reports" variant="chrome" class="p-2 ml-auto no-padding" dropup right>
        <a class="dropdown-item">First Report</a>
        <a class="dropdown-item">Second Report</a>
        <a class="dropdown-item">Third Report</a>
      </b-dropdown> -->
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
import {viewStateIsSuccess} from '~store/resourceForm'

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
    },
    newResource: {
      type: Object,
      default: {}
    },
    noAdd: {
      type: Boolean,
      default: false
    }
  },
  components: {
    ToolbarTop,
    ResourceFormModal,
    ResourceRefreshBtn,
    ResourceAddBtn
  },
  data: ()=> ({
    successAlert: false
  }),
  computed: {
    resourceFormTitle() {
      return `Save ${this.resourceLabelSingular}`
    },
    ...mapState({
      error: ({resource})=> resource.error,
      showSidebar: ({sidebar})=> sidebar.shown
    }),
    ...mapGetters('resource', {
      isSuccess,
      isFailed,
      isLoading
    }),
    ...mapGetters('resourceForm', {
      viewStateIsSuccess
    })
    // currentPage: {
    //   get() {
    //     return this.$route.query.p
    //   },
    //   set(newValue) {
    //     this.$router.replace({query: {p: newValue}})
    //   }
    // },
    // paginationSize() {
    //   return this.showSidebar ? 'sm' : 'md'
    // }
  },
  watch: {
    viewStateIsSuccess(newValue) {
      if (newValue == true) {
        this.successAlert = true
        this.$state
      }
    }
  }
}
</script>
