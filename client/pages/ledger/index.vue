<template>
  <resource-list @saved="handleSaved" no-add>
    <div slot="form">
      <account-form/>
    </div>
    <table class="table table-striped">
      <thead>
      <tr>
        <th>Name</th>
        <th class="text-right">Balance</th>
        <th></th>
      </tr>
      </thead>
      <tbody>
        <tr v-for="(a,i) in accounts">
          <td>
            <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">{{a.ledger_balance | currency(i === 0)}}</td>
          <td>
            <action-button-bar :actions="actions(a)">
            </action-button-bar>
          </td>
        </tr>
      </tbody>
    </table>
  </resource-list>
</template>

<script>
  import {mapState} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import ActionButtonBar from '~components/ActionButtonBar'
  import AccountForm from '~components/accounts/AccountForm'
  import {get} from 'lodash'

  export default {
    components: {
      ResourceList,
      ActionButtonBar,
      AccountForm
    },
    computed: {
      ...mapState({
        accounts: ({resource}) => get(resource, 'data', []).filter((a) => {
          // NOTE: should do this server-side eventually
          return parseFloat(a.ledger_balance) !== 0.0
        })
      })
    },
    methods: {
      handleSaved (event) {
        this.$router.push({name: 'accounts-id', params: {id: event.id}})
      },
      actions (account) {
        return [
          {
            icon: 'eye',
            name: 'show',
            to: {name: 'ledger-id', params: {id: account.id}}
          }
        ]
      }
    },
    async fetch ({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        listRouteName: 'ledger',
        title: 'General Ledger',
        query: {
          include: 'created_by',
          filter: {
            // nonzero_ledger_balance: true
          }
        }
      })
    }
  }
</script>
