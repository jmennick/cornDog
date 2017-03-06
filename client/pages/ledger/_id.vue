<template>
  <resource-detail no-add no-refresh return-location="/ledger">
    <div slot="form">
      <account-form/>
    </div>
    <b-table stripped sortable :items="testData" :fields="fields">
      <template slot="actions" scope="a">
        <action-button-bar :actions="actions(a.item)" right>
        </action-button-bar>
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
        ledger: ({resource}) => resource.selected
      })
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        title: 'Cash',
        id: params.id,
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
        testData: {
            ledger1: {
              date: '10/17/17',
              description: 'Initial Balance',
              transaction_id: '7',
              debit: null,
              credit: null,
              balance: '1000.00'
            },
            ledger2: {
              date: '10/19/17',
              description: 'Squid retro ramps craft beer, celiac man bun scenester vegan church-key kogi',
              transaction_id: '10',
              debit: '500.00',
              credit: null,
              balance: '1500.00'
            }
        },
        fields: {
          date: {label: 'Date', sortable: true},
          description: {label: 'Description', sortable: true},
          transaction_id: {label: 'ID', sortable: true},
          debit: {label: 'Debit', sortable: true},
          credit: {label: 'Credit', sortable: true},
          balance: {label: 'Balance', sortable: true}
      }
    })
  }
</script>
