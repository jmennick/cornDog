<template>
  <b-table stripped :items="journalEntry.items" :fields="fields">
    <template slot="debit" scope="x">
      {{currencyFormatter(x.item.left_value)}}
    </template>
    <template slot="credit" scope="x">
      {{currencyFormatter(x.item.right_value)}}
    </template>
  </b-table>
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
  data: ()=> ({
    fields: {
      date: {label: 'Date'},
      debit: {label: 'Debit'},
      credit: {label: 'Credit'}
    }
  }),
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
