<template>
  <resource-list @saved="handleSaved">
    <account-form slot="form"/>
    <b-table stripped sortable :items="accounts" :fields="fields" class="no-bottom-margin">
      <template slot="active" scope="a">
        <div :class="['badge', 'badge-pill', a.item.active?'badge-success':'badge-danger']">
          <span v-if="a.item.active">Active</span>
          <span v-else>Inactive</span>
        </div>
      </template>
      <template slot="actions" scope="a">
        <action-button-bar :actions="actions(a.item)" right>
        </action-button-bar>
      </template>
    </b-table>
  </resource-list>
</template>

<script>
import {mapState, mapMutations} from 'vuex'
import ResourceList from '~components/ResourceList'
import ActionButtonBar from '~components/ActionButtonBar'
import AccountForm from '~components/accounts/AccountForm'
import {showModal} from '~store/resourceForm'

export default {
  components: {
    ResourceList,
    ActionButtonBar,
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
    },
    handleSaved(event) {
      this.$router.push({name: 'accounts-id', params: {id: event.id}})
    },
    actions(account) {
      return [
        {
          icon: 'eye',
          name: 'show',
          to: {name: 'accounts-id', params: {id: account.id}}
        },
        {
          icon: 'edit',
          name: 'edit',
          action: ()=> { this.editAccount(account) }
        },
        {
          name: account.active?'Deactivate Account':'Activate Account',
          action: ()=> { this.toggleActive(account) }
        }
      ]
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
