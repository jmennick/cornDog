<template>
  <resource-list no-add>
    <table class="trial-balance table table-striped">
      <thead>
      <tr>
        <th>Name</th>
        <th class="text-right">Debit</th>
        <th class="text-right">Credit</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="a in accounts">
        <td>
          <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
            {{a.name}}


          </nuxt-link>
        </td>
        <td class="text-right">
          <span
            v-if="a.normal_side_physical == 'left'">{{currencyFormatter(a.ledger_balance, a.normal_side_physical)}}</span>
        </td>
        <td class="text-right">
          <span
            v-if="a.normal_side_physical == 'right'">{{currencyFormatter(a.ledger_balance, a.normal_side_physical)}}</span>
        </td>
      </tr>
      </tbody>
      <tfoot>
      <tr>
        <td>Total</td>
        <td class="text-right">{{currencyFormatter(totalDebits(), 'left')}}</td>
        <td class="text-right">{{currencyFormatter(totalCredits(), 'right')}}</td>
      </tr>
      </tfoot>
    </table>
  </resource-list>
</template>
<script>
  import {mapState, mapMutations} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import format from 'format'

  export default {
    components: {
      ResourceList
    },
    computed: {
      ...mapState({
        accounts: ({resource}) => resource.data.filter((a) => {
          //NOTE: this is temporary! should do this server-side eventually
          return parseFloat(a.ledger_balance) != 0.0
        })
      })
    },
    methods: {
      currencyFormatter: (val, side) => {
        if (side == 'left') {
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
        else {
          if (val == 0 || !!val) {
            if (val >= 0) {
              return format('(%0.2f)', val)
            } else {
              return format('%0.2f', -val)
            }
          } else {
            return null
          }
        }
      },
      totalDebits() {
        if (this.accounts.length == 0) {
          return null
        }
        return this.accounts.reduce((a, i) => {
          if (i.normal_side_physical == 'left') {
            const v = i.ledger_balance
            a = !a ? 0 : a
            return (!v) ? a : (a + parseFloat(v))
          }
        }, 0)
      },
      totalCredits() {
        if (this.accounts.length == 0) {
          return null
        }
        return this.accounts.reduce((a, i) => {
          if (i.normal_side_physical == 'right') {
            const v = i.ledger_balance
            a = !a ? 0 : a
            return (!v) ? a : (a + parseFloat(v))
          }
        }, 0)
      }
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        listRouteName: 'ledger',
        title: 'Trial Balance',
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
<style>
  .trial-balance {
    max-width: 60% !important;
    margin-left: auto;
    margin-right: auto;
  }
</style>
