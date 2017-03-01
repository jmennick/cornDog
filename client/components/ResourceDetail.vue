<template>
  <div>
    <toolbar-top title="Resource Detail">
      <resource-refresh-btn slot="left"/>
      <resource-add-btn slot="right" v-if="!noAdd"/>
    </toolbar-top>
    <div class="content-container">
      <div class="container-fluid">
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
import {mapGetters} from 'vuex'
import ToolbarTop from '~components/ToolbarTop'
import ResourceFormModal from '~components/ResourceFormModal'
import ResourceRefreshBtn from '~components/ResourceRefreshBtn'
import ResourceAddBtn from '~components/ResourceAddBtn'
import {isSuccess, isLoading, isError} from '~store/resource'

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
    ...mapGetters('resource', {
      isSuccess,
      isLoading,
      isError
    })
  }
}
</script>
