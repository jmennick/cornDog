<template>
  <div id="modal-container" :class="{'modal-open': show}" v-if="show">
    <div class="modal fade" :class="{show: animateShow}" tabindex="-1" role="dialog" style="display: block; padding-left: 0;" @click.self="backdropClicked()">
      <div class="modal-dialog" :class="dialogClasses" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{title}}</h5>
            <button type="button" class="close" aria-label="close" @click="close()">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <slot></slot>
          </div>
          <div class="modal-footer">
            <slot name="footer">
            </slot>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop fade" :class="{show: show}">
    </div>
  </div>
</template>

<script>
const closeEvent = 'close'

export default {
  props: {
    show: {
      type: Boolean,
      required: true
    },
    title: {
      type: String,
      required: true
    },
    size: {
      type: String,
      default: 'md'
    }
  },
  data: () => ({
    animateShow: false
  }),
  computed: {
    dialogClasses () {
      return [`modal-${this.size}`]
    }
  },
  methods: {
    close () {
      this.animateShow = false
      setTimeout(() => {
        this.$emit(closeEvent)
      }, 200)
    },
    backdropClicked () {
      this.close()
    },
    handleShowChanged (newValue) {
      if (newValue) {
        setTimeout(() => {
          this.animateShow = true
        }, 0)
      }
    }
  },
  mounted () {
    this.handleShowChanged(this.show)
  },
  watch: {
    show (newValue) {
      this.handleShowChanged(newValue)
    }
  }
}
</script>

<style scoped>
#modal-container {
  position: fixed;
  top: 0; bottom: 0;
  left: 0; right: 0;
  z-index: 1040;
}
</style>
