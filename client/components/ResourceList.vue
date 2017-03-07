<template>
  <div>
    <toolbar-top :title="title">
      <resource-refresh-btn slot="left"/>
      <resource-add-btn slot="right" v-if="!noAdd"/>
    </toolbar-top>
    <div class="content-container">
      <resource-form-modal :title="resourceFormTitle" :resource="resourceName">
        <slot name="form"></slot>
      </resource-form-modal>
      <div v-if="isLoading">
        Loading...
      </div>
      <resource-loading-failed v-if="isFailed"/>
      <slot v-if="isSuccess"></slot>
    </div>
    <b-navbar type="inverse" variant="chrome" class="fixed-bottom d-flex flex-row align-items-center">
      <b-button variant="chrome">
        Blah
      </b-button>
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
import {viewStateIsSuccess} from '~store/resourceForm'
import {
  isSuccess, isFailed, isLoading, labelSingular, labelPlural
} from '~store/resource'

export default {
  props: {
    noAdd: {
      type: Boolean,
      default: ()=> false
    }
  },
  components: {
    ToolbarTop,
    ResourceFormModal,
    ResourceRefreshBtn,
    ResourceAddBtn
  },
  computed: {
    resourceFormTitle() {
      return `Save ${this.labelSingular}`
    },
    ...mapState({
      resourceName: ({resource})=> resource.name,
      error: ({resource})=> resource.error,
      showSidebar: ({sidebar})=> sidebar.shown,
      title: ({resource})=> resource.title,
      saveResult: ({resourceForm})=> resourceForm.resultData
    }),
    ...mapGetters('resource', {
      isSuccess,
      isFailed,
      isLoading,
      labelSingular,
      labelPlural
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
        this.$emit('saved', this.saveResult)
      }
    }
  }
}
</script>
