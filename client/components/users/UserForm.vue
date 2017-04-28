<template>
  <div class="container-fluid" v-if="user">
    <form>
      <b-form-fieldset label="Name*" :state="!user.name?'danger':null" horizontal>
        <b-form-input v-model="user.name" @input="updateProp('name', $event)" type="text" placeholder="John Doe" />
      </b-form-fieldset>
      <b-form-fieldset label="Email*" :state="!user.email?'danger':null" horizontal>
        <b-form-input v-model="user.email" @input="updateProp('email', $event)" type="email" placeholder="jdoe@example.com" />
      </b-form-fieldset>
      <b-form-fieldset label="Password*" :state="!user.password?'danger':null" horizontal>
        <b-form-input v-model="user.password" @input="updateProp('password', $event)" type="password" />
      </b-form-fieldset>
      <b-form-fieldset label="Role" horizontal>
        <select v-model="role" class="form-control">
          <option v-for="(val, key) in roles" :value="val">
            {{key | titleize}}
          </option>
        </select>
      </b-form-fieldset>
    </form>
  </div>
</template>

<script>
import {mapState, mapMutations} from 'vuex'
import resourceFormMixin from '~assets/js/mixins/resourceFormMixin'
import {enableSaving, disableSaving} from '~store/resourceForm'
import {get} from 'lodash'

export default {
  mixins: [resourceFormMixin],
  computed: {
    ...mapState({
      user: ({resourceForm}) => get(resourceForm, 'modalData', []),
      roles: ({resource}) => get(resource, 'meta.roles', [])
    }),
    isValid () {
      if (!this.user.name) {
        return false
      } else if (!this.user.email) {
        return false
      } else if (!this.user.password) {
        return false
      } else {
        return true
      }
    },
    role: {
      get () {
        return this.user.role
      },
      set (newValue) {
        this.updateProp('role', newValue)
      }
    }
  },
  mounted () {
    this.handleIsValid(this.isValid)
  },
  methods: {
    updateProp (pname, value) {
      console.log('val:', value)
      this.saveData({
        ...this.resource,
        [pname]: value
      })
    },
    handleIsValid (value) {
      if (value) {
        this.enableSaving()
      } else {
        this.disableSaving()
      }
    },
    ...mapMutations('resourceForm', {enableSaving, disableSaving})
  },
  watch: {
    isValid (newValue) {
      this.handleIsValid(newValue)
    }
  }
}
</script>
