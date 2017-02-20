<template>
  <b-button variant="theme" @click="showModal()">
    <icon name="plus"></icon> Add {{resourceName}}
  </b-button>
</template>

<script>
import {mapMutations} from 'vuex'
import {showModal} from '~store/resourceForm'

export default {
  props: {
    resourceName: {
      type: String,
      required: true
    }
  },
  methods: mapMutations('resourceForm', {showModal})
}
</script>
