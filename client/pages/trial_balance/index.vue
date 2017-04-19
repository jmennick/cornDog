<template>
  <resource-list no-add>
    <div class="trial-balance">
      <div class="header-content">
        <h4>CornDog Accounting</h4>
        <h4>Trial Balance</h4>
        <h4>As of {{today}}</h4>
      </div>
    </div>
    <table class="trial-balance table table-striped">
      <thead>
      <tr>
        <th>Name</th>
        <th class="text-right">Debit</th>
        <th class="text-right">Credit</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(a, index) in accounts">
        <td>
          <nuxt-link :to="{'name': 'ledger-id', params: {id: a.id}}">
            {{a.name}}
          </nuxt-link>
        </td>
        <td class="text-right">
          <span v-if="a.normal_side_physical == 'left'" :class="{'underline' : index === accounts.length - 1}">
            {{currencyFormatter(a.ledger_balance, a.normal_side_physical, index, false)}}
          </span>
        </td>
        <td class="text-right">
          <span v-if="a.normal_side_physical == 'right'" :class="{'underline' : index === accounts.length - 1}">
            {{currencyFormatter(a.ledger_balance, a.normal_side_physical, index, false)}}
          </span>
        </td>
      </tr>
      </tbody>
      <tfoot>
      <tr>
        <td>Total</td>
        <td class="text-right">
          <span class="double-underline">{{currencyFormatter(totalDebits(), 'left', 0, false)}}</span>
        </td>
        <td class="text-right">
          <span class="double-underline">{{currencyFormatter(totalCredits(), 'right', 0, true)}}</span>
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
  import moment from 'moment'

  var firstItem = true

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
    props: {
        test: true
    },
    methods: {
      currencyFormatter (val, side, index, reset) {
        if (side == 'left') {
          if (val == 0 || !!val)
                return numeral(val).format(index === 0 ? '($0,0.00)' : '(0,0.00)' )
          else
              return null
        }
        else {
            var formattedCurrency
          if (val == 0 || !!val) {
            formattedCurrency = numeral((val * -1)).format(firstItem ? '($0,0.00)' : '(0,0.00)' )
            firstItem = reset
            return formattedCurrency
          }
          else
              return null
        }
      },
      totalDebits() {
        if (this.accounts.length == 0) {
          return null
        }
        return this.accounts.reduce((a, i) => {
          const v = i.normal_side_physical == 'left' ? i.ledger_balance : 0
          a = !a ? 0 : a
          return (!v) ? a : (a + parseFloat(v))
        }, 0)
      },
      totalCredits() {
        if (this.accounts.length == 0) {
          return null
        }
        return this.accounts.reduce((a, i) => {
          const v = i.normal_side_physical == 'right' ? i.ledger_balance : 0
          a = !a ? 0 : a
          return (!v) ? a : (a + parseFloat(v))
        }, 0)
      }
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        listRouteName: 'ledger',
        title: '',
        query: {
          include: 'created_by',
          filter: {
            // nonzero_ledger_balance: true
          }
        }
      })
    },
    data () {
      return {
        today: moment().format('MMMM Do YYYY'),
        firstItem: true
      }
    }
  }
</script>
