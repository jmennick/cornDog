<template>
  <resource-list>
    <journal-entry-form slot="form"/>
    <b-table class="table-striped" :items="transactions" :fields="fields">
      <template slot="created_by" scope="j">
        {{j.item.created_by.name}}
      </template>
      <template slot="actions" scope="j">
        <nuxt-link class="mr-2 btn btn-secondary btn-sm" :to="{name: 'journals-id', params: {id: j.item.id}}"><icon name="eye"></icon></nuxt-link>
      </template>
    </b-table>
  </resource-list>
</template>
<script>
import {mapState} from 'vuex'
import ResourceList from '~components/ResourceList'
import JournalEntryForm from '~components/JournalEntryForm'

export default {
  components: {
    ResourceList,
    JournalEntryForm
  },
  computed: {
    ...mapState({
      transactions: ({resource})=> resource.data
    })
  },
  async fetch({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'journal_entry',
      query: {include: 'created_by'},
      newResource: {
        created_by: null,
        items: [
          {
            left_value: null,
            right_value: null
          }
        ]
      }
    })
  },
  data: ()=> ({
    fields: {
      created_at: {label: 'Created On', sortable: true},
      // title: {label: 'Transaction Name', sortable: true},
      created_by: {label: 'Created By'},
      actions: {}
    }
  })
}
</script>
