<template>
  <b-button variant="theme" @click="addNew()">
    <icon name="plus"></icon> Add {{labelSingular}}
  </b-button>
</template>

<script>
import {mapMutations, mapState, mapGetters} from 'vuex'
import {labelSingular} from '~store/resource'
import {showModal} from '~store/resourceForm'

export default {
  computed: {
    ...mapGetters('resource', {labelSingular}),
    ...mapState({
      newResource: ({resource})=> resource.newResource
    })
  },
  methods: {
    ...mapMutations('resourceForm', {showModal}),
    addNew() {
      this.showModal(this.newResource)
    }
  }
}
</script>
