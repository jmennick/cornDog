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
          <td class="text-right">{{account.initial_balance | currency(true)}}</td>
        </tr>
        <tr v-for="entry in account.ledger_entries">
          <td>{{entry.date}}</td>
          <td>{{entry.description}}</td>
          <td class="text-right">
            <nuxt-link :to="{name: 'journals-id', params: {id: entry.transaction_id}}">
              #{{entry.transaction_id}}
            </nuxt-link>
          </td>
          <td class="text-right">
            <span v-if="entry.left_amount !== null">
              {{entry.left_amount | currency}}
            </span>
          </td>
          <td class="text-right">
            <span v-if="entry.right_amount !== null">
              {{entry.right_amount | currency}}
            </span>
          </td>
          <td class="text-right">
            {{entry.balance | currency}}
          </td>
        </tr>
      </tbody>
    </table>
  </resource-detail>
</template>

<script>
  import {mapState} from 'vuex'
  import ResourceDetail from '~components/ResourceDetail'
  import AccountForm from '~components/accounts/AccountForm'

  export default {
    components: {
      ResourceDetail,
      AccountForm
    },
    computed: {
      ...mapState({
        account: ({resource}) => resource.selected
      })
    },
    async fetch ({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        listRouteName: 'ledger',
        id: params.id,
        title: '',
        query: {include: 'ledger_entries'}
      })
    },
    methods: {
      accountLabel: (account) => account ? `${account.code} ${account.name}` : ''
    }
  }
</script>
