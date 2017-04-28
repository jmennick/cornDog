<template>
  <table class="table table-striped">
    <thead>
      <tr>
        <th>Account</th>
        <th class="text-right">Debit</th>
        <th class="text-right">Credit</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(item, index) in leftJournalEntry">
        <td>{{item.account_name}}</td>
        <td class="text-right">
            {{item.left_value | currency(index === 0)}}
        </td>
        <td>&nbsp;</td>
      </tr>
      <tr v-for="(item,index) in rightJournalEntry">
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{item.account_name}}</td>
        <td></td>
        <td class="text-right">
            {{item.right_value | currency(index === 0)}}
        </td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th>Totals</th>
        <th class="text-right">{{totalDebit | currency(true)}}</th>
        <th class="text-right">{{totalCredit | currency(true)}}</th>
      </tr>
    </tfoot>
  </table>
</template>

<script>
import {filter, get} from 'lodash'

export default {
  props: {
    journalEntry: {
      type: Object,
      required: true
    }
  },
  computed: {
    leftJournalEntry() {
      return filter(get(this.journalEntry, 'items', []), i => i.left_value !== null)
    },
    rightJournalEntry() {
      return filter(get(this.journalEntry, 'items', []), i => i.right_value !== null)
    },
    totalDebit() {
      if (this.journalEntry == null) {
        return null
      }
      return this.journalEntry.items.reduce((a,i)=> {
        const v = i.left_value
        return (v == null) ? a : (a + parseFloat(v))
      }, 0.0)
    },
    totalCredit () {
      if (this.journalEntry == null) {
        return null
      }
      return this.journalEntry.items.reduce((a,i)=> {
        const v = i.right_value
        return (v == null) ? a : (a + parseFloat(v))
      }, 0.0)
    },
    rightJournalEntryItems() {
        return this.journalEntry.items.filter((j) => {j.right_value != null})
    }
  }
}
</script>
