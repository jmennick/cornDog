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
      <resource-action-modal>
      </resource-action-modal>
      <div v-if="isLoading">
        Loading...
      </div>
      <resource-loading-failed v-if="isFailed"/>
      <slot v-if="isSuccess"></slot>
    </div>
  </div>
</template>

<script>
import {mapState, mapGetters} from 'vuex'
import resourceBaseMixin from '~assets/js/mixins/resourceBaseMixin'
import ToolbarTop from '~components/ToolbarTop'
import ResourceFormModal from '~components/ResourceFormModal'
import ResourceActionModal from '~components/ResourceActionModal'
import ResourceRefreshBtn from '~components/ResourceRefreshBtn'
import ResourceLoadingFailed from '~components/ResourceLoadingFailed'
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
  mixins: [resourceBaseMixin],
  components: {
    ToolbarTop,
    ResourceFormModal,
    ResourceActionModal,
    ResourceRefreshBtn,
    ResourceLoadingFailed,
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
  }
  // watch: {
  //   viewStateIsSuccess(newValue) {
  //     if (newValue == true) {
  //       this.$emit('saved', this.saveResult)
  //     }
  //   }
  // }
}
</script>
