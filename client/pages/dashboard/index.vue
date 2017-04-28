<template>
  <resource-list no-add>
    <table class="table table-hover">
      <thead>
      <th><h3 class="font-weight-100">Liquidity Ratios</h3></th>
      <th class="text-right"><h4 class="font-weight-100">{{year.lastYear2}}</h4></th>
      <th class="text-right"><h4 class="font-weight-100">{{year.lastYear}}</h4></th>
      <th class="text-right"><h4 class="font-weight-100">{{year.current}}</h4></th>
      <!--<th class="text-right"><h4 class="font-weight-100">Status</h4></th>-->
      </thead>
      <tbody>
      <tr v-for="l in liquidityRatios">
        <td>{{l.name}}</td>
        <td class="text-right">{{l.ratios[0] | currency}}</td>
        <td class="text-right">{{l.ratios[1] | currency}}</td>
        <td class="text-right">{{l.ratios[2] | currency}}</td>
        <!--<td></td>-->
      </tr>
      </tbody>
      <thead>
      <th><h3 class="font-weight-100">Operating Ratios</h3></th>
      <th class="text-right"></th>
      <th class="text-right"></th>
      <th class="text-right"></th>
      <!--<th class="text-right"></th>-->
      </thead>
      <tbody>
      <tr v-for="o in operatingRatios">
        <td>{{o.name}}</td>
        <td class="text-right">{{o.ratios[0] | currency}}</td>
        <td class="text-right">{{o.ratios[1] | currency}}</td>
        <td class="text-right">{{o.ratios[2] | currency}}</td>
        <!--<td></td>-->
      </tr>
      </tbody>
      <thead>
      <th><h3 class="font-weight-100">Debt Management Ratios</h3></th>
      <th class="text-right"></th>
      <th class="text-right"></th>
      <th class="text-right"></th>
      <!--<th class="text-right"></th>-->
      </thead>
      <tbody>
      <tr v-for="d in debtManagement">
        <td>{{d.name}}</td>
        <td class="text-right">{{d.ratios[0] | currency}}</td>
        <td class="text-right">{{d.ratios[1] | currency}}</td>
        <td class="text-right">{{d.ratios[2] | currency}}</td>
        <!--<td></td>-->
      </tr>
      </tbody>
      <thead>
      <th><h3 class="font-weight-100">Profitability Ratios</h3></th>
      <th class="text-right"></th>
      <th class="text-right"></th>
      <th class="text-right"></th>
      <!--<th class="text-right"></th>-->
      </thead>
      <tbody>
      <tr v-for="p in profitabilityRatios">
        <td>{{p.name}}</td>
        <td class="text-right">{{p.ratios[0] | currency}}</td>
        <td class="text-right">{{p.ratios[1] | currency}}</td>
        <td class="text-right">{{p.ratios[2] | currency}}</td>
        <!--<td></td>-->
      </tr>
      </tbody>
      <thead>
      <th><h3 class="font-weight-100">Valuation Ratios</h3></th>
      <th class="text-right"></th>
      <th class="text-right"></th>
      <th class="text-right"></th>
      <!--<th class="text-right"></th>-->
      </thead>
      <tbody>
      <tr v-if="dividendAccount.length > 0" v-for="v in valuationRatios">
        <td>{{v.name}}</td>
        <td class="text-right">{{v.ratios[0] | currency}}</td>
        <td class="text-right">{{v.ratios[1 | currency]}}</td>
        <td class="text-right">{{v.ratios[2] | currency}}</td>
        <!--<td></td>-->
      </tr>
      <tr v-else>
        <td>No dividends reported</td>
      </tr>
      </tbody>
    </table>
    <!--<div class="row text-center">-->
    <!--<div v-for="d in dashboardItems" class="col-lg-3 col-md-4 col-sm-6">-->
    <!--<h3 class="font-weight-100">{{d.name}}</h3>-->
    <!--<h1 class="font-weight-100">{{d.ratio}}</h1>-->
    <!--</div>-->
    <!--</div>-->
  </resource-list>
</template>
<script>
  import {mapState, mapMutations} from 'vuex'
  import ResourceList from '~components/ResourceList'
  import {sumBy} from 'lodash'
  import {get} from 'lodash'
  import moment from 'moment'

  export default {
    components: {
      ResourceList
    },
    computed: {
      ...mapState({
        accounts: ({resource}) => get(resource, 'data', []).filter((a) => {
          //NOTE: this is temporary! should do this server-side eventually
          return parseFloat(a.ledger_balance) != 0.0
        })
      }),
      year() {
        return {
          current: moment().format('YYYY'),
          lastYear: moment().subtract(1, 'years').format('YYYY'),
          lastYear2: moment().subtract(2, 'years').format('YYYY')
        }
      },
      currentAssets () {
        return this.accounts.filter((a) => (a.kind == 'current_asset'))
      },
      currentLiabilities () {
        var accounts = this.accounts.filter((a) => (a.kind == 'current_liability'))
        if (accounts.length == 0)
          return [{ledger_balance: 1}]
        else
          return accounts
      },
      inventory() {
        return this.accounts.filter((a) => (a.name == 'Supplies'))
      },
      liquidityRatios() {
        return [
          {
            name: 'Current Ratio',
            ratios: [
              0, //2015
              0, //2016
              Math.abs(sumBy(this.currentAssets, (a) => parseFloat(a.ledger_balance)) / sumBy(this.currentLiabilities, (a) => parseFloat(a.ledger_balance))) //2017
            ]
          },
          {
            name: 'Quick Ratio',
            ratios: [
              0, //2015
              0,  //2016
              Math.abs((sumBy(this.currentAssets, (a) => parseFloat(a.ledger_balance)) - sumBy(this.inventory, (a) => parseFloat(a.ledger_balance))) / sumBy(this.currentLiabilities, (a) => parseFloat(a.ledger_balance)))
            ]
          },
        ]
      },
      annualSales() {
        return this.accounts.filter((a) => (a.kind == 'revenue'))
      },
      totalAssets() {
        return this.accounts.filter((a) => (a.kind == 'current_asset') || (a.kind == 'long_term_asset'))
      },
      operatingRatios() {
        return [
          {
            name: 'Total Assets Turnover',
            ratios: [
              0, //2015
              0, //2016
              Math.abs(sumBy(this.annualSales, (a) => parseFloat(a.ledger_balance)) / sumBy(this.totalAssets, (a) => parseFloat(a.ledger_balance))) //2017
            ]
          },
          {
            name: 'Inventory Turnover',
            ratios: [
              0, //2015
              0,  //2016
              Math.abs(sumBy(this.annualSales, (a) => parseFloat(a.ledger_balance)) / sumBy(this.inventory, (a) => parseFloat(a.ledger_balance)))
            ]
          },
        ]
      },
      longTermDebt() {
        return this.accounts.filter((a) => (a.kind == 'long_term_liability'))
      },
      shareHolderEquity() {
        return this.accounts.filter((a) => (a.kind == 'equity'))
      },
      totalLiabilities() {
        return this.accounts.filter((a) => (a.kind == 'current_liability') || (a.kind == 'long_term_liability'))
      },
      debtManagement() {
        return [
          {
            name: 'Debt/Equity Ratio',
            ratios: [
              0, //2015
              0, //2016
              Math.abs(sumBy(this.longTermDebt, (a) => parseFloat(a.ledger_balance)) / sumBy(this.shareHolderEquity, (a) => parseFloat(a.ledger_balance))) //2017
            ]
          },
          {
            name: 'Debt Ratio',
            ratios: [
              0, //2015
              0,  //2016
              Math.abs(sumBy(this.totalLiabilities, (a) => parseFloat(a.ledger_balance)) / sumBy(this.shareHolderEquity, (a) => parseFloat(a.ledger_balance)))
            ]
          },
        ]
      },
      netIncome() {
        return this.accounts.filter((a) => (a.kind == 'revenue') || (a.kind == 'expense'))
      },
      profitabilityRatios() {
        return [
          {
            name: 'Profit Margin (Return on Sales)',
            ratios: [
              0, //2015
              0, //2016
              Math.abs(sumBy(this.netIncome, (a) => parseFloat(a.ledger_balance)) / sumBy(this.annualSales, (a) => parseFloat(a.ledger_balance))) //2017
            ]
          },
          {
            name: 'Return on Equity',
            ratios: [
              0, //2015
              0,  //2016
              Math.abs(sumBy(this.netIncome, (a) => parseFloat(a.ledger_balance)) / sumBy(this.shareHolderEquity, (a) => parseFloat(a.ledger_balance)))
            ]
          },
        ]
      },
      dividendAccount() {
          return this.accounts.filter((a) => (a.name == 'Dividends'))
      },
      stockPrice() {
          return 0
      },
      valuationRatios() {
        return [
          {
            name: 'Earnings Per Share (EPS)',
            ratios: [
              0, //2015
              0, //2016
              Math.abs(sumBy(this.netIncome, (a) => parseFloat(a.ledger_balance)) / this.dividendAccount.ledger_balance) //2017
            ]
          },
          {
            name: 'Price/Earnings Ratio',
            ratios: [
              0, //2015
              0,  //2016
              Math.abs((this.stockPrice) / (sumBy(this.netIncome, (a) => parseFloat(a.ledger_balance)) / this.dividendAccount.ledger_balance)) //2017
            ]
          },
        ]
      }
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        listRouteName: 'retained_earnings',
        title: 'Dashboard',
      })
    }
  }
</script>
