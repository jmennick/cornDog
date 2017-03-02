<template>
  <div class="container-fluid">
    <form>
      <items-table :journal-entry="journalEntry">
      </items-table>
    </form>
  </div>
</template>

<script>
import {mapState} from 'vuex'
import ItemsTable from '~components/journal_entries/ItemsTable'

export default {
  components: {
    ItemsTable
  },
  computed: {
    ...mapState({
      journalEntry: ({resourceForm})=> resource.modalData
    })
  },
  data: ()=> ({
    fields: {
      date: {label: 'Date'},
      credit: {label: 'Credit'},
      debit: {label: 'Debit'}
    }
  })
}
</script>
