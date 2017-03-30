<template>
  <resource-detail :title="account?account.name:''">
    <small slot="title-left">{{account?account.code:''}}</small>
    <div slot="form">
      <account-form/>
    </div>
    <b-table stripped sortable v-if="account" :items="account.ledger_entries" :fields="fields">
      <template slot="transaction_id" scope="x">
        <nuxt-link :to="{name: 'journals-id', params: {id: x.item.transaction_id}}">
          #{{x.item.transaction_id}}
        </nuxt-link>
      </template>
    </b-table>
  </resource-detail>
</template>

<script>
  import {mapState} from 'vuex'
  import ResourceDetail from '~components/ResourceDetail'
  import AccountForm from '~components/accounts/AccountForm'
  import {selected} from '~store/resource'

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
      fields: {
        date: {label: 'Date', sortable: true},
        description: {label: 'Description', sortable: true},
        transaction_id: {label: 'ID', sortable: true},
        left_amount: {label: 'Debit', sortable: true},
        right_amount: {label: 'Credit', sortable: true},
        balance: {label: 'Balance', sortable: true}
      }
    }),
    methods: {
      accountLabel: (account)=> account?`${account.code} ${account.name}`:''
    }
  }
</script>
