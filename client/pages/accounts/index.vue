<template>
  <resource-list resource="account" resource-label-singular="Account" resource-label-plural="Accounts" :new-resource="newAccount">
    <div slot="form">
      <account-form />
    </div>
    <b-table class="table-striped" :items="accounts" :fields="fields">
      <template slot="active" scope="a">
        <div class="badge badge-pill" :class="{'badge-success': a.item.active, 'badge-danger': !a.item.active}">
          <span v-if="a.item.active">Active</span>
          <span v-else>Inactive</span>
        </div>
        &nbsp;
        <b-button size="sm"><icon :name="activeToggleLabel(a.item.active)"></icon></b-button>
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
    }),
    newAccount() {
      return {
        active: false,
        code: null,
        description: null,
        kind: 'current_asset',
        created_by_id: 1,
        name: null,
        order: null,
        type: 'accounts'
      }
    }
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
