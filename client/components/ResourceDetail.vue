<template>
  <div>
    <toolbar-top :title="title">
      <div slot="left">
        <resource-refresh-btn v-if="!noRefresh"/>
        <nuxt-link class="return-location" v-else :to="returnLocation">
          <b-button variant="theme">
            <icon name="arrow-left"></icon> Return
          </b-button>
        </nuxt-link>
      </div>
      <!-- <icon name="chevron-left" slot="title-left"></icon> -->
      <resource-add-btn slot="right" v-if="!noAdd"/>
      <!-- <b-button variant="theme" slot="title-right">Edit</b-button> -->
    </toolbar-top>
    <div class="content-container">
      <div class="container-fluid">
        <resource-form-modal :title="resourceFormTitle" :resource="resourceName">
          <slot name="form"></slot>
        </resource-form-modal>
        <div v-if="isLoading">
          Loading...
        </div>
        <resource-loading-failed v-if="isFailed"/>
        <slot v-if="isSuccess"></slot>
      </div>
    </div>
    <b-navbar type="inverse" variant="chrome" class="fixed-bottom d-flex flex-row align-items-center">
    </b-navbar>
  </div>
</template>

<script>
import {mapState, mapGetters} from 'vuex'
import ToolbarTop from '~components/ToolbarTop'
import ResourceFormModal from '~components/ResourceFormModal'
import ResourceRefreshBtn from '~components/ResourceRefreshBtn'
import ResourceAddBtn from '~components/ResourceAddBtn'
import {isSuccess, isLoading, isFailed, labelSingular} from '~store/resource'

export default {
  props: {
    noAdd: {
      type: Boolean,
      default: ()=> false
    },
    noRefresh: {
      type: Boolean,
      default: ()=> false
    },
    returnLocation: {
      type: String,
      default: '/accounts'
    }
  },
  components: {
    ToolbarTop,
    ResourceFormModal,
    ResourceRefreshBtn,
    ResourceAddBtn
  },
  computed: {
    ...mapState({
      resourceName: ({resource})=> resource.name,
      title: ({resource})=> resource.title
    }),
    ...mapGetters('resource', {
      isSuccess,
      isLoading,
      isFailed,
      labelSingular
    }),
    resourceFormTitle() {
      return `Save ${this.labelSingular}`
    }
  }
}
</script>
