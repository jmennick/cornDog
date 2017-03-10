<template>
  <resource-detail no-refresh return-location="/journals">
    <journal-entry-form slot="form"/>
    <form v-if="!!journalEntry">
      <b-form-fieldset label="Created By" horizontal>
        <p class="form-control-static">{{journalEntry.created_by.name}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Date" horizontal>
        <p class="form-control-static">{{journalEntry.date}}</p>
      </b-form-fieldset>
      <items-table :journal-entry="journalEntry"></items-table>
    </form>
  </resource-detail>
</template>

<script>
import {mapState} from 'vuex'
import ResourceDetail from '~components/ResourceDetail'
import ItemsTable from '~components/journal_entries/ItemsTable'
import JournalEntryForm from '~components/JournalEntryForm'
import {selected} from '~store/resource'

export default {
  components: {
    ResourceDetail,
    ItemsTable,
    JournalEntryForm
  },
  computed: {
    ...mapState({
      journalEntry: ({resource})=> resource.selected
    })
  },
  async fetch({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'journal_entry',
      id: params.id,
      query: {include: 'created_by'},
      newResource: {
        date: null,
        items: [
          {
            left_value: null,
            right_value: null
          }
        ]
      }
    })
  }
}
</script>
