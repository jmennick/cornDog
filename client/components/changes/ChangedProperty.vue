<template>
  <span>
    <span v-if="value">{{value}}</span>
    <span v-else class="text-muted">Unchanged</span>
  </span>
</template>

<script>
export default {
  props: {
    value: {
      required: true
    }
  }
}
</script>
