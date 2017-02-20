<template>
  <div>
  <h1>This is an account form</h1>
  <form>
    <b-form-input v-model="resource.name"
                  type="text"
                  placeholder="Account Name"></b-form-input>
    <!--Add select for acccount type-->

    <!--/Add select for acccount type-->
    <b-form-input v-model="resource.balance"
                  type="number"
                  placeholder="Initial Balance"></b-form-input>
    <b-form-input v-model="resource.code"
                  type="number"
                  placeholder="Account Code"></b-form-input>
    <b-form-input v-model="resource.order"
                  type="number"
                  placeholder="Order"></b-form-input>
    <b-form-input v-model="resource.description"
                  type="text"
                  placeholder="Description"></b-form-input>
    <label>
    <input type="checkbox" class="form-check-input">
      Active
    </label>
  </form>
  </div>
</template>

<script>;
import {mapState} from 'vuex'
import resourceFormMixin from '~assets/js/mixins/resourceFormMixin'

export default {
  mixins: [resourceFormMixin],
  computed: {
    ...mapState({
        types: ({resource})=> resource.meta.kinds_grouped
    })
  }
}
</script>
