<template>
  <resource-list no-add>
    <div class="trial-balance">
      <div class="header-content">
        <h4 class="font-weight-100">CornDog Accounting</h4>
        <h4 class="font-weight-100">Trial Balance</h4>
        <h4 class="font-weight-100">As of {{today}}</h4>
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
        <tr v-for="(a, index) in debitAccounts">
          <td>
            <nuxt-link :to="{name: 'ledger-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td class="text-right">
            {{a.ledger_balance | currency(index === 0)}}
          </td>
          <td></td>
        <tr v-for="(a, index) in creditAccounts">
          <td>
            <nuxt-link :to="{name: 'ledger-id', params: {id: a.id}}">
              {{a.name}}
            </nuxt-link>
          </td>
          <td></td>
          <td class="text-right">
            {{-a.ledger_balance | currency(index === 0)}}
          </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td>Total</td>
          <td class="text-right top-border">
            <span class="double-underline">
              {{totalDebits | currency(true)}}
            </span>
          </td>
          <td class="text-right top-border">
            <span class="double-underline">
              {{totalCredits | currency(true)}}
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
  import moment from 'moment'
  import {get} from 'lodash'

  export default {
    components: {
      ResourceList
    },
    computed: {
      ...mapState({
        accounts: ({resource}) => get(resource, 'data', []).filter((a) => {
          //NOTE: this is temporary! should do this server-side eventually
          return parseFloat(a.ledger_balance) != 0.0
        }),
        debitAccounts() {
          return this.accounts.filter((a) => {
            return a.ledger_balance > 0
          })
        },
        creditAccounts() {
          return this.accounts.filter((a) => {
            return a.ledger_balance < 0
          })
        }
      }),
      totalDebits() {
        return this.accounts.reduce((a, i) => {
          const v = i.ledger_balance > 0 ? i.ledger_balance : 0
          a = !a ? 0 : a
          return (!v) ? a : (a + parseFloat(v))
        }, 0)
      },
      totalCredits() {
        return this.accounts.reduce((a, i) => {
          const v = i.ledger_balance < 0 ? -i.ledger_balance : 0
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
    data: ()=> ({
      today: moment().format('MMMM Do YYYY'),
      firstItem: true
    })
  }
</script>

<style scoped>
  .date {
    padding-top: 20px;
    padding-bottom: 20px;
    display: flex;
    flex-direction: row;
    justify-content: center;
    padding-left: 3em;
  }
</style>
