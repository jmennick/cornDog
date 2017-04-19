<template>
  <resource-list no-add>
    <div class="balance-sheet-header">
      <div class="header-content">
        <h4>Corndog Accounting</h4>
        <h4>Balance Sheet</h4>
        <h4>As of {{today}}</h4>
      </div>
    </div>
    <div class="d-flex flex-row">
      <table class="balance-sheet-tables table table-striped">
        <thead>
        <tr>
          <th><h4>Current Assets</h4></th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(currentA, index) in currentAssetAccounts" class="underline">
          <td>
            <nuxt-link :to="{'name': 'ledger-id', params: {id: currentA.id}}">
              {{currentA.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            <span>{{currencyFormatter(currentA.ledger_balance, currentA.normal_side_physical, index)}}</span>
          </td>
        </tr>
        <tr>
          <td>Total Current Assets</td>
          <td class="text-right">
            <u>{{currencyFormatter(sumAssets('current'), 'left')}}</u>
          </td>
        </tr>
        </tbody>
        <thead>
        <tr>
          <th><h4>Long-Term Assets</h4></th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(longA, index) in longAssetAccounts">
          <td>
            <nuxt-link :to="{'name': 'ledger-id', params: {id: longA.id}}">
              {{longA.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            {{currencyFormatter(longA.ledger_balance, longA.normal_side_physical, index)}}
          </td>
        </tr>
        <tr>
          <td>Total Long-Term Assets</td>
          <td class="text-right">
            <u>{{currencyFormatter(sumAssets('long'), 'left')}}</u>
          </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
          <td>Total Assets</td>
          <td class="text-right">
            <span class="double-underline">{{currencyFormatter(sumAssets(), 'left', 0)}}</span>
          </td>
        </tr>
        </tfoot>
      </table>
      <!--Liabilities-->
      <table class="balance-sheet-tables table table-striped">
        <thead>
        <tr>
          <th><h4>Current Liabilities</h4></th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(currentL, index) in currentLiabilityAccounts">
          <td>
            <nuxt-link :to="{'name': 'ledger-id', params: {id: currentL.id}}">
              {{currentL.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            {{currencyFormatter(currentL.ledger_balance, currentL.normal_side_physical, index)}}
          </td>
        </tr>
        <tr>
          <td>Total Current Liabilities</td>
          <td class="text-right">
            <u>{{currencyFormatter(sumLiabilities('current'), 'right')}}</u>
          </td>
        </tr>
        </tbody>
        <thead>
        <tr>
          <th><h4>Long-Term Liabilities</h4></th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(longL, index) in longLiabilityAccounts">
          <td>
            <nuxt-link :to="{'name': 'ledger-id', params: {id: longL.id}}">
              {{longL.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            {{currencyFormatter(longL.ledger_balance, longL.normal_side_physical, index)}}
          </td>
        </tr>
        <tr>
          <td>Total Long-Term Liabilities</td>
          <td class="text-right">
            <u>{{currencyFormatter(sumLiabilities('long'), 'right')}}</u>
          </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
          <td>Total Liabilities</td>
          <td class="text-right">
            <span class="double-underline">{{currencyFormatter(sumLiabilities(), 'right', 0)}}</span>
          </td>
        </tr>
        </tfoot>
      </table>
      <!--Owners Equity-->
      <!--add table here-->
    </div>
  </resource-list>
</template>
<style>
  .balance-sheet-tables {
    max-width: calc(50% - 30px);
    margin-right: 10px;
    margin-left: 20px;
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
<script>
  import {mapState, mapMutations} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import numeral from 'numeral'
  import NuxtLink from "../../.nuxt/components/nuxt-link";
  import {sumBy} from 'lodash'
  import moment  from 'moment'

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
      assetAccounts() {
        return this.accounts.filter((a) => (a.kind == 'current_asset') || (a.kind == 'long_term_asset'))
      },
      currentAssetAccounts() {
        return this.accounts.filter((a) => (a.kind == 'current_asset'))
      },
      longAssetAccounts() {
        return this.accounts.filter((a) => (a.kind == 'long_term_asset'))
      },
      liabilityAccounts() {
        return this.accounts.filter((a) => (a.kind == 'current_liability') || (a.kind == 'long_term_liability'))
      },
      currentLiabilityAccounts() {
        return this.accounts.filter((a) => (a.kind == 'current_liability'))
      },
      longLiabilityAccounts() {
        return this.accounts.filter((a) => (a.kind == 'long_term_liability'))
      }
    },
    methods: {
      currencyFormatter: (val, side, index) => {
        if (side == 'left') {
          if (val == 0 || !!val) {
                return numeral(val).format(index === 0 ? '$(0,0.00)' : '(0,0.00)')
          } else {
            return null
          }
        }
        else {
          if (val == 0 || !!val) {
              return numeral((val * -1)).format(index === 0 ? '$(0,0.00)' : '(0,0.00)')
          } else {
            return null
          }
        }
      },
      sumAssets(type) {
        switch (type) {
          case 'current':
            return sumBy(this.currentAssetAccounts, (a) => parseFloat(a.ledger_balance))
            break;
          case 'long':
            return sumBy(this.longAssetAccounts, (a) => parseFloat(a.ledger_balance))
            break;
          default:
            return sumBy(this.assetAccounts, (a) => parseFloat(a.ledger_balance))
        }
      },
      sumLiabilities(type) {
        switch (type) {
          case 'current':
            return sumBy(this.currentLiabilityAccounts, (a) => parseFloat(a.ledger_balance))
            break;
          case 'long':
            return sumBy(this.longLiabilityAccounts, (a) => parseFloat(a.ledger_balance))
            break;
          default:
            return sumBy(this.liabilityAccounts, (a) => parseFloat(a.ledger_balance))
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
