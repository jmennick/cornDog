<template>
  <resource-list @saved="handleSaved" no-add>
    <div slot="form">
      <account-form />
    </div>
    <b-table stripped sortable :items="accounts" :fields="fields">
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
      handleSaved(event) {
        this.$router.push({name: 'accounts-id', params: {id: event.id}})
      },
      actions(account) {
        return [
          {
            icon: 'eye',
            name: 'show',
            to: {name: 'ledger-id', params: {id: account.id}}
          }
        ]
      }
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        title: 'General Ledger',
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
        name: {label: 'Account', sortable: true},
        balance: {label: 'Balance', sortable: true},
        actions: {sortable: false}
      }
    })
  }
</script>
