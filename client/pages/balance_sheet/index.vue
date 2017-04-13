<template>
  <resource-list no-add>
    <div class="d-flex flex-row">
      <table class="balance-sheet-tables table table-striped">
        <thead>
        <tr>
          <th>Assets</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="a in assetAccounts">
          <td>
            <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
              {{currencyFormatter(a.ledger_balance, a.normal_side_physical)}}
          </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
          <td>Total</td>
          <td class="text-right">{{currencyFormatter(sumAssets, 'left')}}</td>
        </tr>
        </tfoot>
      </table>
      <table class="balance-sheet-tables table table-striped">
        <thead>
        <tr>
          <th>Liabilities</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="a in liabilityAccounts">
          <td>
            <nuxt-link :to="{'name': 'accounts-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            {{currencyFormatter(a.ledger_balance, a.normal_side_physical)}}
          </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
          <td>Total</td>
          <td class="text-right">{{currencyFormatter(sumLiabilities, 'right')}}</td>
        </tr>
        </tfoot>
      </table>
    </div>
  </resource-list>
</template>
<style>
  .balance-sheet-tables {
    max-width: calc(50% - 30px);
    margin-right: 10px;
    margin-left: 20px;
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
          return this.accounts.filter((a)=> (a.kind == 'current_asset') || (a.kind == 'long_term_asset'))
      },
      liabilityAccounts() {
        return this.accounts.filter((a)=> (a.kind == 'current_liability') || (a.kind == 'long_term_liabilities'))
      },
      sumAssets() {
          return sumBy(this.assetAccounts, (a)=> parseFloat(a.ledger_balance))
      },
      sumLiabilities() {
        return sumBy(this.liabilityAccounts, (a)=> parseFloat(a.ledger_balance))

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
      }
    }
  }
</script>
