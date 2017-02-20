<template>
  <modal :show="modalShown" @close="cancel()" :title="title" :size="size">
    <slot></slot>
    <template slot="footer">
      <b-button variant="secondary" @click="cancel()">
        Cancel
      </b-button>
      <b-button variant="primary" @click="save()" :disabled="viewStateIsSaving">
        <span v-if="viewStateIsSaving"><icon name="circle-o-notch" spin></icon> Saving</span>
        <span v-else>Save</span>
      </b-button>
    </template>
  </modal>
</template>

<script>
import Modal from '~components/Modal'
import {mapGetters, mapMutations} from 'vuex'

import {
  modalShown, closeModal, beginSaving,
  viewStateIsSaving
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
    }
  },
  components: {
    Modal
  },
  computed: {
    ...mapGetters('resourceForm', {
      modalShown, viewStateIsSaving
    })
  },
  methods: {
    ...mapMutations('resourceForm', {
      closeModal, beginSaving
    }),
    cancel() {
      this.closeModal()
    },
    save() {
      this.beginSaving()
      setTimeout(()=> {
        this.closeModal()
      }, 1000);
    }
  }
}
</script>
