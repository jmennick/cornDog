<template>
  <modal :show="modalShown" @close="cancelAction" :title="title" :size="size">
    <slot>Are you sure?</slot>
    <template slot="footer">
      <b-button variant="secondary" @click="cancelAction">
        Cancel
      </b-button>
      <b-button :variant="confirmColor" @click="execute">
        <span v-if="viewStateIsExecuting">
          <icon name="circle-o-notch" spin></icon>
          Executing
        </span>
        <span v-else>
          <template v-if="confirmIcon">
            <icon :name="confirmIcon"></icon>
            &nbsp;
          </template>
          {{confirmName}}
        </span>
      </b-button>
    </template>
  </modal>
</template>

<script>
import Modal from '~components/Modal'
import {mapState, mapGetters, mapMutations, mapActions} from 'vuex'

import {
  modalShown, cancelAction, viewStateIsExecuting, execute, humanActionName,
  confirmName, confirmIcon, confirmColor
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
      modalShown, viewStateIsExecuting, humanActionName,
      confirmName, confirmIcon, confirmColor
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
