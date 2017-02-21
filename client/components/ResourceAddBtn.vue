<template>
  <b-button variant="theme" @click="addNew()">
    <icon name="plus"></icon> Add {{resourceName}}
  </b-button>
</template>

<script>
import {mapMutations, mapState} from 'vuex'
import {showModal} from '~store/resourceForm'

export default {
  props: {
    resourceName: {
      type: String,
      required: true
    },
    newResource: {
      type: Object,
      default: {}
    }
  },
  methods: {
    ...mapMutations('resourceForm', {showModal}),
    addNew() {
      this.showModal(this.newResource)
    }
  }
}
</script>
