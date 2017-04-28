<template>
  <resource-list no-add>
    <div class="balance-sheet-header">
      <div class="header-content">
        <h4 class="font-weight-100">Corndog Accounting</h4>
        <h4 class="font-weight-100">Balance Sheet</h4>
        <h4 class="font-weight-100">As of {{today}}</h4>
      </div>
    </div>
    <div class="d-flex flex-row">
      <div class="balance-sheet-tables">
        <table class="table">
          <thead>
          <tr>
            <th colspan="2">
              <h4 class="font-weight-100">Current Assets</h4>
            </th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(a,i) in currentAssetAccounts" class="underline">
            <td>
              <nuxt-link :to="{'name': 'ledger-id', params: {id: a.id}}">
                {{a.name}}

              </nuxt-link>
            </td>
            <td :class="{'text-right': true, underline: (i === currentAssetAccounts.length-1)}">
              {{a.ledger_balance | currency(i === 0)}}

            </td>
          </tr>
          <tr>
            <td>Total Current Assets</td>
            <td class="text-right">
            <span class="underline">
              {{sumAssets('current') | currency(true)}}
            </span>
            </td>
          </tr>
          </tbody>
          <thead>
          <tr>
            <th colspan="2">
              <h4 class="font-weight-100">Long-Term Assets</h4>
            </th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(a,i) in longAssetAccounts">
            <td>
              <nuxt-link :to="{'name': 'ledger-id', params: {id: a.id}}">
                {{a.name}}

              </nuxt-link>
            </td>
            <td :class="{'text-right': true, underline: (i === longAssetAccounts.length-1)}">
              {{a.ledger_balance | currency(i === 0)}}

            </td>
          </tr>
          <tr>
            <td>Total Long-Term Assets</td>
            <td class="text-right">
            <span class="underline">
              {{sumAssets('long') | currency(true)}}
            </span>
            </td>
          </tr>
          </tbody>
          <tfoot>
          <tr>
            <td><span class="font-weight-bold">Total Assets</span></td>
            <td class="text-right">
            <span class="double-underline">
              {{sumAssets() | currency(true)}}
            </span>
            </td>
          </tr>
          </tfoot>
        </table>
      </div>
      <!--Liabilities-->
      <div class="d-column balance-sheet-tables">
        <table class="table">
          <thead>
          <tr>
            <th colspan="2">
              <h4 class="font-weight-100">Current Liabilities</h4>
            </th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(a,i) in currentLiabilityAccounts">
            <td>
              <nuxt-link :to="{'name': 'ledger-id', params: {id: a.id}}">
                {{a.name}}

              </nuxt-link>
            </td>
            <td :class="{'text-right': true, underline: (i === currentLiabilityAccounts.length-1)}">
              {{-a.ledger_balance | currency(i === 0)}}

            </td>
          </tr>
          <tr>
            <td>Total Current Liabilities</td>
            <td class="text-right">
              <span class="underline">
                {{-sumLiabilities('current') | currency(true)}}
              </span>
            </td>
          </tr>
          </tbody>
          <thead>
          <tr>
            <th colspan="2">
              <h4 class="font-weight-100">Long-Term Liabilities</h4>
            </th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(a,i) in longLiabilityAccounts">
            <td>
              <nuxt-link :to="{'name': 'ledger-id', params: {id: a.id}}">
                {{a.name}}

              </nuxt-link>
            </td>
            <td :class="{'text-right': true, underline: (i === longLiabilityAccounts.length-1)}">
              {{-a.ledger_balance | currency(i === 0)}}

            </td>
          </tr>
          <tr>
            <td>Total Long-Term Liabilities</td>
            <td class="text-right">
              <span class="text-underlined underline">
                {{-sumLiabilities('long') | currency(true)}}
              </span>
            </td>
          </tr>
          </tbody>
          <tfoot>
          <tr>
            <td><span class="font-weight-bold">Total Liabilities</span></td>
            <td class="text-right">
              <span class="double-underline">
                {{-sumLiabilities() | currency(true)}}
              </span>
            </td>
          </tr>
          </tfoot>
        </table>

        <!--Owners Equity-->

        <table class="table">
          <thead>
          <tr>
            <th colspan="2">
              <h4 class="font-weight-100">Owners Equity</h4>
            </th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(a,i) in equityAccounts">
            <td>
              <nuxt-link :to="{'name': 'ledger-id', params: {id: a.id}}">
                {{a.name}}
              </nuxt-link>
            </td>
            <td :class="{'text-right': true, underline: (i === currentLiabilityAccounts.length-1)}">
              {{-a.ledger_balance | currency(i === 0)}}

            </td>
          </tr>
          <tr>
            <td>
              <nuxt-link to="/income_statement">
                Retained Earnings
              </nuxt-link>
            </td>
            <td class="text-right">
              <span class="underline">
                {{-sumRetainedEarnings() | currency}}
              </span>
            </td>
          </tr>
          <tr>
            <td><span class="font-weight-bold">Total Owners Equity</span></td>
            <td class="text-right">
              <span class="double-underline">
                {{-sumEquity() | currency(true)}}
              </span>
            </td>
          </tr>
          </tbody>
          <tfoot>
          <tr>
            <td><span class="font-weight-bold">Total Liability and Owners Equity</span></td>
            <td class="text-right">
              <span class="double-underline">
                {{-sumLiabilityAndEquity() | currency(true)}}
              </span>
            </td>
          </tr>
          </tfoot>
        </table>
      </div>
    </div>
  </resource-list>
</template>

<script>
  import {mapState, mapMutations} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import NuxtLink from "../../.nuxt/components/nuxt-link";
  import {sumBy} from 'lodash'
  import moment  from 'moment'
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
      assetAccounts() {
        return this.accounts.filter((a) => {
          return (a.kind == 'current_asset') || (a.kind == 'long_term_asset')
        })
      },
      currentAssetAccounts() {
        return this.accounts.filter((a) => {
          return a.kind == 'current_asset'
        })
      },
      longAssetAccounts() {
        return this.accounts.filter((a) => {
          return a.kind == 'long_term_asset'
        })
      },
      liabilityAccounts() {
        return this.accounts.filter((a) => {
          return (a.kind == 'current_liability') || (a.kind == 'long_term_liability')
        })
      },
      currentLiabilityAccounts() {
        return this.accounts.filter((a) => {
          return a.kind == 'current_liability'
        })
      },
      longLiabilityAccounts() {
        return this.accounts.filter((a) => {
          return a.kind == 'long_term_liability'
        })
      },
      equityAccounts() {
        return this.accounts.filter((a) => (a.kind == 'equity'))
      },
      incomeAccounts() {
        return this.accounts.filter((a) => (a.kind == 'revenue') || (a.kind == 'expense'))
      },
      allEquityAccounts() {
        return this.accounts.filter((a) => (a.kind == 'revenue') || (a.kind == 'expense') || (a.kind == 'equity'))
      },
      allLiabilitiesAndEquityAccounts() {
        return this.accounts.filter((a) => (a.kind == 'revenue') || (a.kind == 'expense') || (a.kind == 'equity') || (a.kind == 'current_liability') || (a.kind == 'long_term_liability'))
      }
    },
    methods: {
      sumLiabilityAndEquity() {
        return sumBy(this.allLiabilitiesAndEquityAccounts, (a) => parseFloat(a.ledger_balance))
      },
      sumRetainedEarnings() {
        return sumBy(this.incomeAccounts, (a) => parseFloat(a.ledger_balance))
      },
      sumEquity() {
        return sumBy(this.allEquityAccounts, (a) => parseFloat(a.ledger_balance))
      },
      sumAssets(type) {
        switch (type) {
          case 'current':
            return sumBy(this.currentAssetAccounts, (a) => {
              return parseFloat(a.ledger_balance)
            })
          case 'long':
            return sumBy(this.longAssetAccounts, (a) => {
              return parseFloat(a.ledger_balance)
            })
          default:
            return sumBy(this.assetAccounts, (a) => {
              return parseFloat(a.ledger_balance)
            })
        }
      },
      sumLiabilities(type) {
        switch (type) {
          case 'current':
            return sumBy(this.currentLiabilityAccounts, (a) => {
              return parseFloat(a.ledger_balance)
            })
          case 'long':
            return sumBy(this.longLiabilityAccounts, (a) => {
              return parseFloat(a.ledger_balance)
            })
          default:
            return sumBy(this.liabilityAccounts, (a) => {
              return parseFloat(a.ledger_balance)
            })
        }
      }
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        listRouteName: 'balance_sheet',
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
  .balance-sheet-tables {
    width: calc(100% - 30px);
    margin-right: 15px;
    margin-left: 15px;
  }

  .balance-sheet-header {
    max-width: calc(100% - 30px);
    margin-left: auto;
    margin-right: auto;
  }

  .double-underline {
    border-bottom: 3px black double;
  }
</style>
