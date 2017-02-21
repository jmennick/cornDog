<template>
  <modal :show="modalShown" @close="closeModal()" :title="title" :size="size">
    <slot></slot>
    <template slot="footer">
      <b-button variant="secondary" @click="closeModal()">
        Cancel
      </b-button>
      <b-button variant="primary" @click="save(resource)" :disabled="viewStateIsSaving">
        <span v-if="viewStateIsSaving"><icon name="circle-o-notch" spin></icon> Saving</span>
        <span v-else>Save</span>
      </b-button>
    </template>
  </modal>
</template>

<script>
import Modal from '~components/Modal'
import {mapState, mapGetters, mapMutations, mapActions} from 'vuex'

import {
  modalShown, closeModal, beginSaving,
  viewStateIsSaving, save
} from '~store/resourceForm'

export default {
  props: {
    title: {
      type: String,
      required: true
    },
    size: {
      type: String,
      default: 'lg'
    },
    resource: {
      type: String,
      required: true
    }
  },
  components: {
    Modal
  },
  computed: {
    ...mapState({
      modalData: ({resourceForm})=> resourceForm.modalData
    }),
    ...mapGetters('resourceForm', {modalShown, viewStateIsSaving})
  },
  methods: {
    ...mapMutations('resourceForm', {closeModal, beginSaving}),
    ...mapActions('resourceForm', {save})
  }
}
</script>
