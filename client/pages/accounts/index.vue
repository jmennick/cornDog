<template>
  <resource-list>
    <div slot="form">
      <account-form />
    </div>
    <b-table class="table-striped" :items="accounts" :fields="fields">
      <template slot="active" scope="a">
        <div class="badge badge-pill" :class="{'badge-success': a.item.active, 'badge-danger': !a.item.active}" @click="toggleActive(a.item)">
          <span v-if="a.item.active">Active</span>
          <span v-else>Inactive</span>
        </div>
      </template>
      <template slot="actions" scope="a">
        <nuxt-link class="mr-2 btn btn-secondary btn-sm" :to="{name: 'accounts-id', params: {id: a.item.id}}"><icon name="eye"></icon></nuxt-link>
        <!--<b-button size="sm" variant="secondary" class="mr-2"><icon name="eye"></icon></b-button>-->
        <b-button size="sm" variant="secondary" class="mr-2" @click="editAccount(a.item)"><icon name="edit"></icon></b-button>
      </template>
    </b-table>
  </resource-list>
</template>

<script>
import {mapState, mapMutations} from 'vuex'
import ResourceList from '~components/ResourceList'
import AccountForm from '~components/accounts/AccountForm'
import {showModal} from '~store/resourceForm'

export default {
  components: {
    ResourceList,
    AccountForm
  },
  computed: {
    ...mapState({
      accounts: ({resource})=> resource.data
    })
  },
  methods: {
    activeToggleLabel(account) {
      return account.active ? 'ban' : 'thumbs-up'
    },
    toggleActive(account) {
      if (account.active) {
        if (confirm('Are you sure you want to deactivate this account?')) {
          alert('-Deactivate Account-')
        }
      } else {
        if (confirm('Are you sure you want to activate this account?')) {
          alert('-Activate Account-')
        }
      }
    },
    ...mapMutations('resourceForm', {showModal}),
    editAccount(account) {
      this.showModal(account)
    }
  },
  async fetch({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'account',
      query: {include: 'created_by'},
      newResource: {
        active: false,
        code: null,
        description: null,
        kind: 'current_asset',
        created_by_id: 1,
        initial_balance: 0.0,
        name: null,
        order: null,
        type: 'accounts'
      }
    })
  },
  data: ()=> ({
    fields: {
      code: {label: 'Code', sortable: true},
      name: {label: 'Name', sortable: true},
      kind_human: {label: 'Kind', sortable: true},
      active: {label: 'Active', sortable: true},
      actions: {sortable: false}
    }
  })
}
</script>
