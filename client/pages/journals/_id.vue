<template>
  <resource-detail no-add no-refresh return-location="/journals">
    <form>
      <b-form-fieldset label="Created By" horizontal>
        <p class="form-control-static">{{journalEntry.created_by.name}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Created At" horizontal>
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
import {selected} from '~store/resource'

export default {
  components: {
    ResourceDetail,
    ItemsTable
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
        date: new Date(),
        items: [
          {
            normal_side: 'left',
            amount: 1.0
          },
          {
            normal_side: 'right',
            amount: 1.0
          }
        ]
      }
    })
  }
}
</script>
