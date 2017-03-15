<template>
  <modal :show="!isAuthenticated" title="Sign In" size="md">
    <form @keyup.enter="signIn()">
      <b-form-fieldset label="Email" horizontal>
        <b-form-input v-model="email" type="email"></b-form-input>
      </b-form-fieldset>
      <b-form-fieldset label="Password" horizontal>
        <b-form-input v-model="password" type="password"></b-form-input>
      </b-form-fieldset>
    </form>
    <template slot="footer">
      <b-button variant="primary" @click="signIn()">
        <!-- <span v-if="viewStateIsSaving"><icon name="circle-o-notch" spin></icon> Saving</span>
        <span v-else>Save</span> -->
        <span>Sign in</span>
      </b-button>
    </template>
  </modal>
</template>

<script>
import Modal from '~components/Modal'
import {mapMutations, mapGetters, mapActions} from 'vuex'
import {isAuthenticated, authenticate} from '~store/auth'

export default {
  components: {
    Modal
  },
  data: ()=> ({
    email: null,
    password: null
  }),
  methods: {
    ...mapActions('auth', {authenticate}),
    signIn() {
      this.authenticate({
        email: this.email,
        password: this.password
      }).then(()=> {
        this.email = null
        this.password = null
      })
    }
  },
  computed: {
    ...mapGetters('auth', {isAuthenticated})
  }
}
</script>
