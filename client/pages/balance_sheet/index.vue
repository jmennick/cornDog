<template>
  <resource-list no-add>
    <div class="d-flex flex-row">
      <table class="balance-sheet-tables table table-striped">
        <thead>
        <tr>
          <th>Current Assets</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="a in currentAssetAccounts" class="underline">
          <td>
            <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            <span>{{currencyFormatter(a.ledger_balance, a.normal_side_physical)}}</span>
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
          <th>Long-Term Assets</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="a in longAssetAccounts">
          <td>
            <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            {{currencyFormatter(a.ledger_balance, a.normal_side_physical)}}
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
            <span class="double-underline">{{currencyFormatter(sumAssets(), 'left')}}</span>
          </td>
        </tr>
        </tfoot>
      </table>
      <!--Liabilities-->
      <table class="balance-sheet-tables table table-striped">
        <thead>
        <tr>
          <th>Current Liabilities</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="a in currentLiabilityAccounts">
          <td>
            <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            {{currencyFormatter(a.ledger_balance, a.normal_side_physical)}}
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
          <th>Long-Term Liabilities</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="a in longLiabilityAccounts">
          <td>
            <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            {{currencyFormatter(a.ledger_balance, a.normal_side_physical)}}
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
            <span class="double-underline">{{currencyFormatter(sumLiabilities(), 'right')}}</span>
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

  .double-underline {
    border-bottom: 3px black double;
  }
</style>
<script>
  import {mapState, mapMutations} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import format from 'format'
  import NuxtLink from "../../.nuxt/components/nuxt-link";
  import {sumBy} from 'lodash'

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
        return this.accounts.filter((a) => (a.kind == 'current_liability') || (a.kind == 'long_term_liabilities'))
      },
      currentLiabilityAccounts() {
        return this.accounts.filter((a) => (a.kind == 'current_liability'))
      },
      longLiabilityAccounts() {
        return this.accounts.filter((a) => (a.kind == 'long_term_liabilities'))
      }
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
        listRouteName: 'ledger',
        title: 'Balance Sheet',
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
