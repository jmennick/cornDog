<template>
  <form>
    <div class="form-group">
      <label for="description-label" class="col-form-label-lg">Comments</label>
      <b-form-input id="description-label" textarea size="lg" v-model="description"></b-form-input>
    </div>
  </form>
</template>

<script>
import {mapState, mapMutations} from 'vuex'
import {saveData} from '~store/resourceAction'

export default {
  computed: {
    ...mapState({
      data: ({resourceAction}) => resourceAction.data
    }),
    description: {
      get() {
        return this.data.description
      },
      set(newValue) {
        this.saveData({...this.data, description: newValue})
      }
    }
  },
  methods: {
    ...mapMutations('resourceAction', {saveData})
  }
}
</script>
