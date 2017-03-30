<template>
  <section>
    <toolbar-top></toolbar-top>
    <div class="content-container">
      <h1 class="title">
        {{ error.statusCode }}
      </h1>
      <h2 class="info">
        {{ error.message }}
      </h2>
      <nuxt-link class="button" to="/" v-if="error.statusCode === 404">
        Homepage
      </nuxt-link>
    </div>
  </section>
</template>
<script>
import ToolbarTop from '~components/ToolbarTop'

export default {
  props: ['error'],
  components: {
    ToolbarTop
  }
}
</script>

<style scoped>
.error-section {

}
</style>
