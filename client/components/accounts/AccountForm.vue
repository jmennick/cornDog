<template>
  <div class="container-fluid">
    <form>
      <b-form-fieldset label="Name" horizontal>
        <b-form-input v-model="name" type="text" placeholder="Account Name"></b-form-input>
      </b-form-fieldset>
      <b-form-fieldset label="Kind" horizontal>
        <select class="form-control" v-model="kind">
          <optgroup v-for="t in types" :label="t.label">
            <option v-for="k in t.kinds" :value="k.value">
              {{k.label}}
            </option>
          </optgroup>
        </select>
      </b-form-fieldset>
      <b-form-fieldset label="Initial Balance" horizontal>
        <b-form-input v-model="initial_balance" type="number" placeholder="Initial Balance"></b-form-input>
      </b-form-fieldset>
      <b-form-fieldset label="Code" horizontal>
        <b-form-input v-model="code" type="number" placeholder="Account Code"></b-form-input>
      </b-form-fieldset>
      <b-form-fieldset label="Order" horizontal>
        <b-form-input v-model="order" type="number" placeholder="Order"></b-form-input>
      </b-form-fieldset>
      <b-form-fieldset label="Description" horizontal>
        <b-form-input v-model="description" type="text" placeholder="Description"></b-form-input>
      </b-form-fieldset>
      <b-form-fieldset label="Active" horizontal>
        <!-- <b-form-checkbox v-model="active" :_value="true">Active</b-form-checkbox> -->
        <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="checkbox" v-model="active">
            Active
          </label>
        </div>
      </b-form-fieldset>
    </form>
  </div>
</template>

<script>
import {mapState} from 'vuex'
import resourceFormMixin from '~assets/js/mixins/resourceFormMixin'

const mapProp = (pname)=> ({
  get() {
    return this.resource[pname]
  },
  set(newValue) {
    let resource = this.resource
    resource[pname] = newValue
    this.saveData(resource)
  }
})

export default {
  mixins: [resourceFormMixin],
  computed: {
    ...mapState({
        types: ({resource})=> resource.meta.kinds_grouped,
    }),
    name: mapProp('name'),
    kind: mapProp('kind'),
    initial_balance: mapProp('initial_balance'),
    code: mapProp('code'),
    order: mapProp('order'),
    description: mapProp('description'),
    active: mapProp('active')
  }
}
</script>
