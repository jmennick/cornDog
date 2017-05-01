<template>
  <modal :show="modalShown" @close="closeModal()" :title="title" :size="size">
    <b-alert :show="viewStateIsError" state="danger" v-if="!!error">
      <strong>Saving Failed</strong>
      <p>
        <span v-for="e in error.errors">{{e.status}} {{e.detail}}<br /></span>
      </p>
    </b-alert>
    <br v-if="viewStateIsError"/>
    <slot></slot>
    <template slot="footer">
      <b-button variant="secondary" @click="closeModal()">
        Cancel
      </b-button>
      <b-button variant="primary" @click="save(resource)" :disabled="saveButtonIsDisabled">
        <span v-if="viewStateIsSaving"><icon name="circle-o-notch" spin></icon> Saving</span>
        <span v-else>Save</span>
      </b-button>
    </template>
  </modal>
</template>

<script>
import Modal from '~components/Modal'
import {mapState, mapGetters, mapMutations, mapActions} from 'vuex'
import {fetch} from '~store/resource'
import {get} from 'lodash'

import {
  modalShown, closeModal, beginSaving, save,
  viewStateIsSaving, viewStateIsError, viewStateIsSuccess
} from '~store/resourceForm'

export default {
  props: {
    title: {
      type: String,
      required: true
    },
    size: {
      type: String,
      default: 'flex'
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
      modalData: ({resourceForm}) => resourceForm.modalData,
      resultData: ({resourceForm}) => resourceForm.resultData,
      canSave: ({resourceForm}) => get(resourceForm, 'canSave', false),
      error: ({resourceForm}) => resourceForm.error,
      paradigm: ({resourceForm}) => resourceForm.paradigm,
      showRouteArticle: ({resource}) => resource.showRouteArticle
    }),
    ...mapGetters('resourceForm', {
      modalShown, viewStateIsSaving, viewStateIsError, viewStateIsSuccess
    }),
    saveButtonIsDisabled () {
      return this.viewStateIsSaving || !this.canSave
    }
  },
  methods: {
    ...mapMutations('resourceForm', {closeModal, beginSaving}),
    ...mapActions('resourceForm', {save}),
    ...mapActions('resource', {fetch})
  }
}
</script>
