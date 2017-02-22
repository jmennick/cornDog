<template>
  <resource-list resource="account" resource-label-singular="Transaction" resource-label-plural="Journal">
    <div slot="form">
      <account-form/>
    </div>
    <b-table stripped class="table-striped" :items="transactions" :fields="fields">
      <template slot="actions" scope="a">
        <nuxt-link class="mr-2 btn btn-default btn-sm" to="/details"><icon name="eye" @click="showTransaction(a.item)"></icon></nuxt-link>
      </template>
    </b-table>
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
          transactions: ({resource})=> resource.data
    })
  },
  methods: {
        showTransactions(transactionItem) {
          console.log(transactionItem);
    }
  },
  async fetch({params, store}) {
    await store.commit('resource/loadingSuccessful', [
      {date: '1-24-2017', user: 'Michael Russell', title: 'Transaction #4855'},
      {date: '1-29-2017', user: 'Elizabeth Herndon', title: 'Transaction #8818'},
      {date: '2-4-2017', user: 'Joshua Mennicke', title: 'Transaction #6996'},
      {date: '2-8-2017', user: 'Gavin Smith', title: 'Transaction #420'},
      {date: '2-9-2017', user: 'Ryan Josefburg', title: 'Transaction #2345'}
      ])
  },
  data: ()=> ({
    fields: {
      date: {label: 'Date', sortable: true},
      title: {label: 'Transaction Name', sortable: true},
      user: {label: 'Created By', sortable: true},
      actions: {sortable: false}
    }
  })
  }
</script>
