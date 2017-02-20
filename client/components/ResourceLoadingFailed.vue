<template>
  <div>
    <h1>Loading Failed</h1>
    <p class="lead">{{error}}</p>
  </div>
</template>

<script>
import {mapState} from 'vuex'
import {isFailed} from '~store/resource'

export default {
  computed: mapState({
    error: ({resource})=> resource.error
  })
}
</script>
