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
      <tr v-for="(item, index) in journalEntry.items">
        <td>
          <span v-if="!!item.right_value">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          </span>
          {{item.account_name}}
        </td>
        <td class="text-right">
          <span v-if="item.left_value !== null">
            {{item.left_value | currency(index === 0)}}
          </span>
        </td>
        <td class="text-right">
          <span v-if="item.right_value !== null">
            {{item.right_value | currency(index === 0)}}
          </span>
        </td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th>Totals</th>
        <th class="text-right">{{totalDebit | currency}}</th>
        <th class="text-right">{{totalCredit | currency}}</th>
      </tr>
    </tfoot>
  </table>
</template>

<script>
import format from 'format'

export default {
  props: {
    journalEntry: {
      type: Object,
      required: true
    }
  },
  computed: {
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
    }
  }
}
</script>
