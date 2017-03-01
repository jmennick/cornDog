<template>
  <div>
    <toolbar-top title="Resource Detail">
      <!-- <resource-refresh-btn slot="left"/> -->
      <!-- <resource-add-btn slot="right" v-if="!noAdd"/> -->
    </toolbar-top>
    <div class="content-container">
      <div class="container-fluid">
        <slot></slot>
      </div>
    </div>
    <b-navbar type="inverse" variant="chrome" class="fixed-bottom d-flex flex-row align-items-center">
    </b-navbar>
  </div>
</template>

<script>
import ToolbarTop from '~components/ToolbarTop'
import ResourceFormModal from '~components/ResourceFormModal'
import ResourceRefreshBtn from '~components/ResourceRefreshBtn'
import ResourceAddBtn from '~components/ResourceAddBtn'

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
  }
}
</script>
