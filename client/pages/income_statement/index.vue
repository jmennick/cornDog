<template>
  <resource-list no-add>
    <div class="trial-balance" v-if="accounts.length">
      <div class="header-content">
        <h4 class="font-weight-100">CornDog Accounting</h4>
        <h4 class="font-weight-100">Income Statement</h4>
        <h4 class="font-weight-100">As of {{today}}</h4>
      </div>
    </div>
    <table class="trial-balance table table-striped">
      <thead>
      <tr>
        <th colspan="2">
          <h4 class="font-weight-100">Revenue Accounts</h4>
        </th>
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
          <span>{{r.ledger_balance | currency(index === 0)}}</span>
        </td>
      </tr>
      <tr>
        <td>Total Revenue</td>
        <td :class="{'text-right': true, underline: (index === revenueAccounts.length-1)}">
          <u>{{sumRevenue | currency}}</u>
        </td>
      </tr>
      </tbody>
      <thead>
      <tr>
        <th colspan="2">
          <h4 class="font-weight-100">Expense Accounts</h4>
        </th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(e, index) in expenseAccounts">
        <td>
          <nuxt-link :to="{'name': 'ledger-id', params: {id: e.id}}">
            {{e.name}}
          </nuxt-link>
        </td>
        <td :class="{'text-right': true, underline: (index === expenseAccounts.length-1)}">
          {{e.ledger_balance(index === 1)}}
        </td>
      </tr>
      <tr>
        <td>Total Expense</td>
        <td class="text-right">
          <span class="underline">
            {{sumExpense | currency}}
          </span>
        </td>
      </tr>
      </tbody>
      <tfoot>
      <tr>
        <td>Income</td>
        <td class="text-right">
          <span class="double-underline">
            {{sumIncome | currency(true)}}
          </span>
        </td>
      </tr>
      </tfoot>
    </table>
  </resource-list>
</template>
<script>
  import {mapState, mapMutations} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import NuxtLink from "../../.nuxt/components/nuxt-link";
  import {sumBy} from 'lodash'
  import moment from 'moment'
  import numeral from 'numeral'
  import {get} from 'lodash'

  export default {
    components: {
      NuxtLink,
      ResourceList
    },
    computed: {
      ...mapState({
        accounts: ({resource}) => get(resource, 'data', []).filter((a) => {
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
      },
      sumRevenue() {
        return sumBy(this.revenueAccounts, (a) => -parseFloat(a.ledger_balance))
      },
      sumExpense() {
        return sumBy(this.expenseAccounts, (a) => parseFloat(a.ledger_balance))
      },
      sumIncome() {
        return sumBy(this.incomeAccounts, (a) => parseFloat(a.ledger_balance))
      }
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
