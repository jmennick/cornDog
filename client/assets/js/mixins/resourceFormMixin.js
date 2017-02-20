export default {
  computed: {
    resource: {
      get() {
        return this.$store.resourceForm.modalData
      },
      set(newValue) {
        this.$store.commit('resourceForm/saveData', newValue)
      }
    }
  }
}
