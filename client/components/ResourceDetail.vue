<template>
  <div>
    <toolbar-top :title="toolbarTitle">
      <div slot="left">
        <!-- <resource-refresh-btn v-if="!noRefresh"/> -->
        <nuxt-link class="return-location" :to="listRoute">
          <b-button variant="theme">
            <icon name="arrow-left"></icon> {{backButtonTitle}}
          </b-button>
        </nuxt-link>
      </div>
      <template slot="title-left"><slot name="title-left"></slot></template>
      <resource-add-btn slot="right" v-if="!noAdd"/>
      <!-- <b-button variant="theme" slot="title-right">Edit</b-button> -->
      <template slot="title-right"><slot name="title-right"></slot></template>
    </toolbar-top>
    <div class="content-container">
      <resource-form-modal :title="resourceFormTitle" :resource="resourceName">
        <slot name="form"></slot>
      </resource-form-modal>
      <resource-action-modal>
        <slot :name="actionName"></slot>
      </resource-action-modal>
      <div v-if="isLoading">
        Loading...
      </div>
      <resource-loading-failed v-if="isFailed"/>
      <slot v-if="isSuccess"></slot>
    </div>
    <b-navbar type="inverse" variant="chrome" class="fixed-bottom d-flex flex-row align-items-center">
    </b-navbar>
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

import {
  isSuccess, isLoading, isFailed, labelSingular, listRoute
} from '~store/resource'

export default {
  props: {
    noAdd: {
      type: Boolean,
      default: ()=> false
    },
    // returnLocation: {
    //   type: String,
    //   default: '/accounts'
    // },
    title: {
      type: [String, null],
      default: null
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
    ...mapState({
      resourceName: ({resource})=> resource.name,
      actionName: ({resourceAction})=> resourceAction.name,
      titleBase: ({resource})=> resource.title,
      data: ({resource})=> resource.data,
      backButtonTitle: ({resource})=> resource.backButtonTitle,
      formParadigm: ({resourceForm})=> resourceForm.paradigm
    }),
    ...mapGetters('resource', {
      isSuccess,
      isLoading,
      isFailed,
      labelSingular,
      listRoute
    }),
    resourceFormTitle() {
      return `Save ${this.labelSingular}`
    },
    toolbarTitle() {
      if (this.title !== null) {
        return this.title
      } else {
        return this.titleBase
      }
    }
  }
}
</script>
