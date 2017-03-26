<template>
  <resource-list @saved="handleSaved" no-add>
    <div slot="form">
      <account-form />
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
        <tr v-for="a in accounts">
          <td>
            <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">{{currencyFormatter(a.ledger_balance)}}</td>
          <td>
            <action-button-bar :actions="actions(a)">
            </action-button-bar>
          </td>
        </tr>
      </tbody>
    </table>
    <!-- <b-table stripped sortable :items="accounts" :fields="fields">
      <template slot="actions" scope="a">
        <action-button-bar :actions="actions(a.item)" right>
        </action-button-bar>
      </template>
      <template slot="ledger_balance" scope="a">
        <span class="text-right">
          {{currencyFormatter(a.item.ledger_balance)}}
        </span>
      </template>
    </b-table> -->
  </resource-list>
</template>

<script>
  import {mapState, mapMutations} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import ActionButtonBar from '~components/ActionButtonBar'
  import AccountForm from '~components/accounts/AccountForm'
  import {showModal} from '~store/resourceForm'
  import format from 'format'

  export default {
    components: {
      ResourceList,
      ActionButtonBar,
      AccountForm
    },
    computed: {
      ...mapState({
        accounts: ({resource})=> resource.data.filter( (a)=> {
          //NOTE: this is temporary! should do this server-side eventually
          return parseFloat(a.ledger_balance) != 0.0
        })
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
      },
      currencyFormatter: (val)=> {
        if (val == 0 || !!val) {
          if (val >= 0) {
            return format('%0.2f', val)
          } else {
            return format('(%0.2f)', -val)
          }
        } else {
          return null
        }
      }
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        title: 'General Ledger',
        query: {
          include: 'created_by',
          filter: {
            // nonzero_ledger_balance: true
          }
        }
      })
    },
    data: ()=> ({
      // fields: {
      //   name: {label: 'Account', sortable: true},
      //   ledger_balance: {label: 'Balance', sortable: true},
      //   actions: {sortable: false}
      // }
    })
  }
</script>
