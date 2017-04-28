<template>
  <resource-list no-add>
    <div class="trial-balance" v-if="accounts.length">
      <div class="header-content">
        <h4 class="font-weight-100">CornDog Accounting</h4>
        <h4 class="font-weight-100">Statement of Retained Earnings</h4>
        <h4 class="font-weight-100">For the Year Ended {{endOfMonth}}</h4>
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
      <tr>
        <td>
          Beg Retained Earnings, {{begOfMonth}}
        </td>
        <td class="text-right">
          <span v-if="retainedEarning">{{retainedEarning.ledger_balance | currency(true)}}</span>
          <span v-else>{{0 | currency(true)}}</span>
        </td>
      </tr>
      <tr>
        <td>Add: {{income}}</td>
        <td :class="{'text-right': true}">
          <u>{{-sumIncome | currency}}</u>
        </td>
      </tr>
      <tr>
        <td>Less: Dividends</td>
        <td :class="{'text-right': true, underline: true}">
          <u>{{sumDividends | currency}}</u>
        </td>
      </tr>
      </tbody>
      <tfoot>
      <tr>
        <td>End Retained Earnings, {{endOfMonth}}</td>
        <td class="text-right">
          <span class="double-underline">
            {{-sumEarnings | currency(true)}}
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
      retainedEarning() {
        return this.accounts.filter((a) => (a.name == 'Retained Earnings'))
      },
      dividendAccounts() {
        return this.accounts.filter((a) => (a.name == 'Dividends'))
      },
      incomeAccounts() {
        return this.accounts.filter((a) => (a.kind == 'revenue') || (a.kind == 'expense'))
      },
      earningAccounts() {
        return this.accounts.filter((a) => (a.kind == 'revenue') || (a.kind == 'expense') || a.name == 'Retained Earnings' || a.name == 'Dividends')
      },
      sumDividends() {
        return sumBy(this.dividendAccounts, (a) => parseFloat(a.ledger_balance))
      },
      sumIncome() {
        var sum = sumBy(this.incomeAccounts, (a) => parseFloat(a.ledger_balance))
        this.income = sum <= 0 ? 'Net Income': 'Net Loss'
        return sum
      },
      sumEarnings() {
        return sumBy(this.earningAccounts, (a) => parseFloat(a.ledger_balance))
      }
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        listRouteName: 'retained_earnings',
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
      endOfMonth: moment().endOf('month').format('MMMM Do YYYY'),
      begOfMonth: moment().startOf('month').format('MMMM, Do YYYY'),
      income: 'Net Income'
    })
  }
</script>
<style>
  .double-underline {
    border-bottom: 3px black double;
  }
</style>
