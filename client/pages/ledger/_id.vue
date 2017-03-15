<template>
  <resource-detail no-add no-refresh return-location="/ledger">
    <div slot="form">
      <account-form/>
    </div>
    <b-table stripped sortable :items="ledgerEntries" :fields="fields">
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
        ledgerEntries: ({resource}) => resource.data
      })
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'ledger_entry',
        title: '',
        query: {filter: {account_id: params.id}}
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
    })
  }
</script>
