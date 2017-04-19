<template>
  <resource-list no-add>
    <div class="trial-balance">
      <div class="header-content">
        <h4>CornDog Accounting</h4>
        <h4>Income Statement</h4>
        <h4>As of {{today}}</h4>
      </div>
    </div>
    <table class="trial-balance table table-striped">
      <thead>
      <tr>
        <th>Revenue Accounts</th>
        <th></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(r, index) in revenueAccounts">
        <td>
          <nuxt-link :to="{'name': 'ledger-id', params: {id: r.id}}">
            {{r.name}}
          </nuxt-link>
        </td>
        <td class="text-right">
          <span>{{currencyFormatter(r.ledger_balance, r.normal_side_physical, index)}}</span>
        </td>
      </tr>
      <tr>
        <td>Total Revenue</td>
        <td class="text-right">
          <u>{{currencyFormatter(sumRevenue(), 'right')}}</u>
        </td>
      </tr>
      </tbody>
      <thead>
      <tr>
        <th>Expense Accounts</th>
        <th></th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(e, index) in expenseAccounts">
        <td>
          <nuxt-link :to="{'name': 'ledger-id', params: {id: e.id}}">
            {{e.name}}
          </nuxt-link>
        </td>
        <td class="text-right">
          <span>{{currencyFormatter(e.ledger_balance, e.normal_side_physical, index)}}</span>
        </td>
      </tr>
      <tr>
        <td>Total Expense</td>
        <td class="text-right">
          <u>{{currencyFormatter(sumExpense(), 'left')}}</u>
        </td>
      </tr>
      </tbody>
      <tfoot>
      <tr>
        <td>Income</td>
        <td class="text-right">
          <span class="double-underline">{{currencyFormatter(sumIncome(), 'left', 0)}}</span>
        </td>
      </tr>
      </tfoot>
    </table>
  </resource-list>
</template>
<script>
  import {mapState, mapMutations} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import numeral from 'numeral'
  import NuxtLink from "../../.nuxt/components/nuxt-link";
  import {sumBy} from 'lodash'
  import moment from 'moment'

  export default {
    components: {
      NuxtLink,
      ResourceList
    },
    computed: {
      ...mapState({
        accounts: ({resource}) => resource.data.filter((a) => {
          //NOTE: this is temporary! should do this server-side eventually
          return parseFloat(a.ledger_balance) != 0.0
        })
      }),
      revenueAccounts() {
        return this.accounts.filter((a) => (a.kind == 'revenue'))
      },
      expenseAccounts() {
        return this.accounts.filter((a) => (a.kind == 'expense'))
      },
      incomeAccounts() {
        return this.accounts.filter((a) => (a.kind == 'revenue') || (a.kind == 'expense'))
      }
    },
    methods: {
      currencyFormatter: (val, side, index) => {
        if (side == 'left') {
          if (val == 0 || !!val) {
            return numeral(val).format(index ===0 ? '$(0,0.00)' : '(0,0.00)')
//            if (val >= 0) {
//              return format('%0.2f', val)
//            } else {
//              return format('(%0.2f)', -val)
//            }
          } else {
            return null
          }
        }
        else {
          if (val == 0 || !!val) {
            return numeral((val * -1)).format(index ===0 ? '$(0,0.00)' : '(0,0.00)')
//            if (val <= 0) {
//              return format('%0.2f', -val)
//            } else {
//              return format('(%0.2f)', val)
//            }
          } else {
            return null
          }
        }
      },
      sumRevenue() {
        return sumBy(this.revenueAccounts, (a) => parseFloat(a.ledger_balance))
      },
      sumExpense() {
        return sumBy(this.expenseAccounts, (a) => parseFloat(a.ledger_balance))
      },
      sumIncome() {
        return sumBy(this.incomeAccounts, (a) => parseFloat(a.ledger_balance))
      },
      async fetch({params, store}) {
        await store.dispatch('resource/setup', {
          name: 'account',
          listRouteName: 'income_statement',
          title: '',
          query: {
            include: 'created_by',
            filter: {
              // nonzero_ledger_balance: true
            }
          }
        })
      }
    },
    data: () => ({
      today: moment().format('MMMM Do YYYY')
    })
  }
</script>
<style>
  .double-underline {
    border-bottom: 3px black double;
  }
</style>
