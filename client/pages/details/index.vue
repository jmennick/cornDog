<template>
  <resource-list resource="account" resource-label-singular="Transaction" resource-label-plural="Journal">
    <div slot="form">
      <account-form />
    </div>
    <b-table stripped class="table-striped" :items="transaction" :fields="fields">
      <template slot="account" scope="a">
        <div v-if="a.item.side">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{a.item.account}}</div>
        <div v-else>{{a.item.account}}</div>
      </template>
    </b-table>
    <b-button class="mr-2" size="md">Post</b-button>
    <b-button class="mr-2" size="md">Reject</b-button>
  </resource-list>
</template>
<script>
  import {mapState} from 'vuex'
  import ResourceList from '~components/ResourceList'

  export default {
    components: {
      ResourceList
    },
    computed: {
      ...mapState({
          transaction: ({resource})=> resource.data
  })
  },
  methods: {
    showTransactions(transactionItem) {
      console.log(transactionItem);
    }
  },
  async fetch({params, store}) {
    await store.commit('resource/loadingSuccessful', [
      {account: 'Cash', debit: '100.00'},
      {account: 'A|P', credit: '100.00', side: 'right'}
    ])
  },
  data: ()=> ({
    fields: {
      account: {label: 'Account Name', sortable: true},
      debit: {label: 'Debit', sortable: true},
      credit: {label: 'Credit', sortable: true}
    }
  })
  }
</script>
