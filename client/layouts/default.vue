<template>
  <div :class="{'show-sidebar': showSidebar}">
    <div id="content" class="theme-green">
      <b-navbar type="inverse" variant="chrome" class="d-flex flex-row align-items-center fixed-top text-white">
        <div class="mr-auto">
          <a class="navbar-brand" @click="toggleSidebar()">
            <icon name="bars"></icon>
          </a>
          <a class="navbar-brand" style="margin: 0">
            <corndog-logo style="height: 23px; width: 23px; margin: -2px 6px 0 15px" />
            <span>CornDog Accounting</span>
          </a>
        </div>
        <span class="p-2 no-bottom-margin">&nbsp;</span>
        <div class="ml-auto">
          <p class="navbar-text no-bottom-margin no-bottom-padding no-top-padding" v-if="isAuthenticated">
            {{currentUser.name}}&nbsp;
            <b-button variant="link" @click="logOut()">Log Out</b-button>
          </p>
          <p class="navbar-text no-bottom-margin no-bottom-padding no-top-padding" v-else>
            Logged Out <b-button variant="link" @click="authenticate()">Log In</b-button>
          </p>
        </div>
      </b-navbar>
      <nuxt/>
      <auth-form-modal></auth-form-modal>
    </div>
    <div id="sidebar" class="bg-chrome-under">
      <b-navbar>
        <a class="navbar-brand text-white" @click="toggleSidebar()">
          <icon name="bars"></icon>
        </a>
      </b-navbar>
      <nav class="nav flex-column">
        <nuxt-link v-for="m in modules" class="nav-link chrome-link" :to="m.to" :exact="m.exact">
          {{m.title}}
        </nuxt-link>
      </nav>
    </div>
  </div>
</template>

<script>
import CorndogLogo from '~components/CorndogLogo'
import {mapState, mapMutations, mapGetters, mapActions} from 'vuex'
import AuthFormModal from '~components/AuthFormModal'
import {result} from 'underscore'

import {
  refreshAuthState, isAuthenticated, authenticate, logOut
} from '~store/auth'

import {
  currentUser
} from '~store/resource'

export default {
  components: {
    CorndogLogo,
    AuthFormModal
  },
  computed: {
    ...mapState({
      showSidebar: ({sidebar})=> sidebar.shown
    }),
    ...mapGetters('auth', {isAuthenticated}),
    ...mapGetters('resource', {currentUser}),
    modules() {
      switch(this.currentUser.role) {
        case 'no_access':
          return []
        case 'accountant':
          return [
            this.coeModule,
            this.journalsModule,
            this.ledgerModule,
            this.tbModule,
            this.isModule,
            this.reModule,
            this.bsModule,
            this.dashboardModule,
            this.changesModule
          ]
        case 'manager':
          return [
            this.coeModule,
            this.journalsModule,
            this.ledgerModule,
            this.tbModule,
            this.isModule,
            this.reModule,
            this.bsModule,
            this.dashboardModule,
            this.usersModule,
            this.changesModule
          ]
        case 'admin':
          return [
            this.coeModule,
            this.accountsModule,
            this.journalsModule,
            this.ledgerModule,
            this.tbModule,
            this.isModule,
            this.reModule,
            this.bsModule,
            this.dashboardModule,
            this.usersModule,
            this.changesModule

          ]
        default:
          return []
      }
    },
    coeModule: ()=> ({title: 'Chart of Accounts', to: '/', exact: true}),
    accountsModule: ()=> ({title: 'Manage Accounts', to: '/accounts'}),
    journalsModule: ()=> ({title: 'Journal Entries', to: '/journals'}),
    ledgerModule: ()=> ({title: 'General Ledger', to: '/ledger'}),
    tbModule: ()=> ({title: 'Trial Balance', to: '/trial_balance'}),
    bsModule: ()=> ({title: 'Balance Sheet', to: '/balance_sheet'}),
    isModule: ()=> ({title: 'Income Statement', to: '/income_statement'}),
    reModule: ()=> ({title: 'Retained Earnings', to: '/retained_earnings'}),
    dashboardModule: ()=> ({title: 'Dashboard', to: '/dashboard'}),
    usersModule: ()=> ({title: 'Users', to: '/users'}),
    changesModule: ()=> ({title: 'Events', to: '/changes'})

  },
  mounted() {
    this.refreshAuthState()
  },
  methods: {
    ...mapMutations({
      toggleSidebar: 'sidebar/toggle'
    }),
    ...mapActions('auth', {refreshAuthState, authenticate, logOut})
  },
  watch: {
    [isAuthenticated](newValue, oldValue) {
      if (!oldValue && !!newValue) {
        this.$store.dispatch('resource/fetch')
      }
    }
  }
}
</script>

<style>
#content {
  position: absolute;
  z-index: 100;
}
#content .content-container {
  position: fixed;
  z-index: 1040;
}
#content .navbar,
#content .content-container {
  -webkit-transition: left 0.2s;
  transition: left 0.2s;
}
.show-sidebar > #content .navbar,
.show-sidebar > #content .content-container {
  left: 200px;
}
#sidebar {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 0;
  -webkit-transition: width 0.2s;
  transition: width 0.2s;
  z-index: 4;
}
#sidebar > * {
  opacity: 0;
  -webkit-transition: opacity 0.2s;
  transition: opacity 0.2s;
}
.show-sidebar > #sidebar {
  width: 200px;
}
.show-sidebar > #sidebar > * {
  opacity: 1;
}
</style>
