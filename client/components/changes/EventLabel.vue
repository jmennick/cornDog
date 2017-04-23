<template>
  <span>
    <span v-if="change.event === 'post'" class="text-success">
      <icon name="check"></icon> posted
    </span>
    <span v-else-if="change.event === 'reject'" class="text-danger">
      <icon name="times"></icon> rejected
    </span>
    <span v-else-if="change.event === 'activate'" class="text-success">
      <icon name="thumbs-up"></icon> activated
    </span>
    <span v-else-if="change.event === 'deactivate'" class="text-danger">
      <icon name="thumbs-down"></icon> deactivated
    </span>
    <span v-else-if="change.event === 'create'">
      created
    </span>
    <span v-else-if="change.event === 'update'">
      updated
    </span>
    <span v-else>
      {{change.event}}
    </span>
  </span>
</template>

<script>
export default {
  props: {
    change: {
      type: Object,
      required: true
    }
  }
}
</script>

<style scoped>
svg {
  margin-left: 0.3em !important;
}
</style>
