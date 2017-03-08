<template>
  <modal :show="modalShown" @close="closeModal()" :title="title" :size="size">
    <slot>Are you sure?</slot>
    <template slot="footer">
      <b-button variant="secondary" @click="closeModal()">
        Cancel
      </b-button>
      <b-button variant="primary" @click="execute()">
        <span v-if="viewStateIsExecuting">
          <icon name="circle-o-notch" spin></icon>
          Executing
        </span>
        <span v-else>
          Confirm
        </span>
      </b-button>
    </template>
  </modal>
</template>

<script>
import Modal from '~components/Modal'
import {mapState, mapGetters, mapMutations, mapActions} from 'vuex'

import {
  modalShown, cancelAction, viewStateIsExecuting, execute, humanActionName
} from '~store/resourceAction'

export default {
  props: {
    size: {
      type: String,
      default: 'flex'
    }
  },
  components: {
    Modal
  },
  computed: {
    ...mapState({
      data: ({resourceAction})=> resourceAction.data,
      actionName: ({resourceAction})=> resourceAction.name
    }),
    ...mapGetters('resourceAction', {
      modalShown, viewStateIsExecuting, humanActionName
    }),
    title() {
      return this.humanActionName
    }
  },
  methods: {
    ...mapMutations('resourceAction', {cancelAction}),
    ...mapActions('resourceAction', {execute})
  }
}
</script>
