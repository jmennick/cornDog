<template>
  <resource-list resource="account" resource-label-singular="Account" resource-label-plural="Accounts">
    <div slot="form">
      <account-form />
    </div>
    <b-table stripped :items="accounts" :fields="fields">
      <template slot="active" scope="account">
        <div class="badge badge-pill" :class="{'badge-success': account.active, 'badge-danger': !account.active}">
          <span v-if="account.active">Active</span>
          <span v-else>Inactive</span>
        </div>
        &nbsp;
        <b-button size="sm"><icon :name="activeToggleLabel(account)"></icon></b-button>
      </template>
      <template slot="actions" scope="account">
        <b-button size="sm" class="mr-2"><icon name="eye"></icon></b-button>
        <b-button size="sm" class="mr-2"><icon name="edit"></icon></b-button>
      </template>
    </b-table>
  </resource-list>
</template>

<script>
import {mapState} from 'vuex'
import ResourceList from '~components/ResourceList'
import AccountForm from '~components/accounts/AccountForm'

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
    }
  },
  async fetch({params, store}) {
    await store.dispatch('resource/fetch', 'account')
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
