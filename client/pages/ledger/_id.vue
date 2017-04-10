<template>
  <resource-detail :title="account?account.name:''">
    <small slot="title-left">{{account?account.code:''}}</small>
    <div slot="form">
      <account-form/>
    </div>
    <table class="table table-striped" v-if="account">
      <thead>
        <tr>
          <th>Date</th>
          <th>Description</th>
          <th class="text-right">ID</th>
          <th class="text-right">Debit</th>
          <th class="text-right">Credit</th>
          <th class="text-right">Balance</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{{account.created_at}}</td>
          <td class="text-muted">--Initial Balance--</td>
          <td></td>
          <td></td>
          <td></td>
          <td class="text-right">{{currencyFormatter(account.initial_balance)}}</td>
        </tr>
        <tr v-for="entry in account.ledger_entries">
          <td>{{entry.date}}</td>
          <td>{{entry.description}}</td>
          <td class="text-right">
            <nuxt-link :to="{name: 'journals-id', params: {id: entry.transaction_id}}">
              #{{entry.transaction_id}}
            </nuxt-link>
          </td>
          <td class="text-right">{{currencyFormatter(entry.left_amount)}}</td>
          <td class="text-right">{{currencyFormatter(entry.right_amount)}}</td>
          <td class="text-right">{{currencyFormatter(entry.balance)}}</td>
        </tr>
      </tbody>
    </table>
    <!-- <b-table stripped sortable v-if="account" :items="account.ledger_entries" :fields="fields">
      <template slot="transaction_id" scope="x">
        <nuxt-link :to="{name: 'journals-id', params: {id: x.item.transaction_id}}">
          #{{x.item.transaction_id}}
        </nuxt-link>
      </template>
    </b-table> -->
  </resource-detail>
</template>

<script>
  import {mapState} from 'vuex'
  import ResourceDetail from '~components/ResourceDetail'
  import AccountForm from '~components/accounts/AccountForm'
  import {selected} from '~store/resource'
  import format from 'format'

  export default {
    components: {
      ResourceDetail,
      AccountForm
    },
    computed: {
      ...mapState({
        account: ({resource})=> resource.selected
      })
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        listRouteName: 'ledger',
        id: params.id,
        title: '',
        query: {include: 'ledger_entries'}
      })
    },
    data: ()=> ({
      // fields: {
      //   date: {label: 'Date', sortable: true},
      //   description: {label: 'Description', sortable: true},
      //   transaction_id: {label: 'ID', sortable: true},
      //   left_amount: {label: 'Debit', sortable: true},
      //   right_amount: {label: 'Credit', sortable: true},
      //   balance: {label: 'Balance', sortable: true}
      // }
    }),
    methods: {
      accountLabel: (account)=> account?`${account.code} ${account.name}`:'',
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
    }
  }
</script>
