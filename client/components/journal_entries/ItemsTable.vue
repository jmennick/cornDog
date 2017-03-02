<template>
  <b-table stripped :items="journalEntry.items" :fields="fields">
    <template slot="debit" scope="j">
      <span v-if="isDebit(j.item)">{{j.item.amount}}</span>
    </template>
    <template slot="credit" scope="j">
      <span v-if="isCredit(j.item)">{{j.item.amount}}</span>
    </template>
  </b-table>
</template>

<script>
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
    isCredit: (entry)=> entry.normal_side == 'right',
    isDebit: (entry)=> entry.normal_side == 'left'
  }
}
</script>
