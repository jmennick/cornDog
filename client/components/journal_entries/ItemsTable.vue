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
      <tr v-for="item in journalEntry.items">
        <td>
          <span v-if="!!item.right_value">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          </span>
          {{item.account_name}}
        </td>
        <td class="text-right">
          {{currencyFormatter(item.left_value)}}
        </td>
        <td class="text-right">
          {{currencyFormatter(item.right_value)}}
        </td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <th>Totals</th>
        <th class="text-right">{{currencyFormatter(totalDebit)}}</th>
        <th class="text-right">{{currencyFormatter(totalCredit)}}</th>
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
    totalCredit() {
      if (this.journalEntry == null) {
        return null
      }
      return this.journalEntry.items.reduce((a,i)=> {
        const v = i.right_value
        return (v == null) ? a : (a + parseFloat(v))
      }, 0.0)
    }
  },
  methods: {
    currencyFormatter: (val)=> {
      if (val == 0 || !!val) {
        return format('%0.2f', val)
      } else {
        return null
      }
    }
  }
}
</script>
