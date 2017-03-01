<template>
  <b-button variant="theme" @click="fetch()">
    <icon name="refresh" :spin="isLoading"></icon> Refresh
  </b-button>
</template>

<script>
import {mapGetters, mapActions} from 'vuex'
import {isLoading, fetch} from '~store/resource'

export default {
  computed: mapGetters('resource', {isLoading}),
  methods: mapActions('resource', {fetch})
}
</script>
