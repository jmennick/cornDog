<template>
  <b-navbar type="inverse" variant="theme" class="d-flex flex-row align-items-center fixed-top secondary-nav text-white">
    <div class="mr-auto" style="margin-left: -8px">
      <slot name="left"></slot>
    </div>
    <span class="p-2 text-lg h5 no-bottom-margin">{{title}}</span>
    <div class="ml-auto" style="margin-right: -2px">
      <slot name="right"></slot>
    </div>
  </b-navbar>
</template>

<script>
export default {
  props: {
    title: {
      type: String
    }
  }
}
</script>
