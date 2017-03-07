<template>
  <b-table stripped :items="journalEntry.items" :fields="fields">
    <template slot="debit" scope="x">
      <span v-if="isDebit(x.item)">
        {{x.item.amount}}
      </span>
    </template>
    <template slot="credit" scope="x">
      <span v-if="isCredit(x.item)">
        {{x.item.amount}}
      </span>
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
