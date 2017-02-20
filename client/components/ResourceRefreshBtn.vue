<template>
  <b-button variant="theme" @click="refresh()">
    <icon name="refresh" :spin="isLoading"></icon> Refresh
  </b-button>
</template>

<script>
import {mapGetters, mapActions} from 'vuex'
import {isLoading, fetch} from '~store/resource'

export default {
  props: {
    resource: {
      type: String,
      required: true
    }
  },
  computed: mapGetters('resource', {isLoading}),
  methods: {
    ...mapActions('resource', {fetch}),
    refresh() {
      this.fetch(this.resource)
    }
  }
}
</script>
