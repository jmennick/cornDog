<template>
  <resource-list>
    <journal-entry-form slot="form"/>
    <b-table class="table-striped" :items="transactions" :fields="fields">
      <template slot="created_by" scope="j">
        {{j.item.created_by.name}}
      </template>
      <template slot="actions" scope="j">
        <action-button-bar :actions="actions(j.item)" right>
        </action-button-bar>
      </template>
    </b-table>
  </resource-list>
</template>
<script>
import {mapState} from 'vuex'
import ResourceList from '~components/ResourceList'
import JournalEntryForm from '~components/JournalEntryForm'
import ActionButtonBar from '~components/ActionButtonBar'

export default {
  components: {
    ResourceList,
    JournalEntryForm,
    ActionButtonBar
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
        date: null,
        items: [
          {
            account_id: null,
            left_value: null,
            right_value: null
          }
        ]
      }
    })
  },
  data: ()=> ({
    fields: {
      date: {label: 'Date', sortable: true},
      created_by: {label: 'Created By'},
      actions: {}
    }
  }),
  methods: {
    actions(journalEntry) {
      return [
        {
          icon: 'eye',
          name: 'show',
          to: {name: 'journals-id', params: {id: journalEntry.id}}
        }
      ]
    },
    post(journalEntry) {
      this.$store.commit('resourceAction/showAction', {
        name: 'post',
        resource: 'journal_entry'
      })
    }
  }
}
</script>
