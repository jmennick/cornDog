<template>
  <resource-list @saved="handleSaved">
    <account-form slot="form"/>
    <b-table striped sortable hover :items="accounts" :fields="fields" class="no-bottom-margin">
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
import {showAction} from '~store/resourceAction'

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
        this.showAction({
          name: 'deactivate_account',
          data: {id: account.id},
          confirmName: 'Deactivate',
          confirmIcon: 'thumbs-down',
          confirmColor: 'danger'
        })
      } else {
        this.showAction({
          name: 'activate_account',
          data: {id: account.id},
          confirmName: 'Activate',
          confirmIcon: 'thumbs-up',
          confirmColor: 'success'
        })
      }
    },
    ...mapMutations('resourceForm', {showModal}),
    ...mapMutations('resourceAction', {showAction}),
    editAccount(account) {
      this.showModal(account, 'edit')
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
          icon: account.active?'thumbs-down':'thumbs-up',
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
        order: null
      }
    })
  },
  data: ()=> ({
    fields: {
      code: {label: 'Code', sortable: true},
      name: {label: 'Name', sortable: true},
      kind_human: {label: 'Category', sortable: true},
      active: {label: 'Active', sortable: true},
      actions: {sortable: false}
    }
  })
}
</script>
