<template>
  <resource-detail no-refresh return-location="/journals">
    <journal-entry-form slot="form"/>
    <post-journal-entry-form slot="post_journal_entry"/>
    <form v-if="!!journalEntry">
      <b-form-fieldset label="Created By" horizontal>
        <p class="form-control-static">{{journalEntry.created_by.name}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Date" horizontal>
        <p class="form-control-static">{{journalEntry.date}}</p>
      </b-form-fieldset>
      <items-table :journal-entry="journalEntry"></items-table>
    </form>
    <b-button-group toolbar size="lg" class="pull-right" v-if="journalEntry.state === 'pending'">
      <b-button variant="danger" @click="reject" :disabled="!isSuccess">
        <icon name="times"></icon> Reject
      </b-button>
      &nbsp;&nbsp;
      <b-button variant="success" @click="post" :disabled="!isSuccess">
        <icon name="check"></icon> Post
      </b-button>
    </b-button-group>
  </resource-detail>
</template>

<script>
import {mapState, mapMutations, mapGetters} from 'vuex'
import ResourceDetail from '~components/ResourceDetail'
import ItemsTable from '~components/journal_entries/ItemsTable'
import PostJournalEntryForm from '~components/journal_entries/PostJournalEntryForm'
import JournalEntryForm from '~components/JournalEntryForm'
import {selected, isSuccess} from '~store/resource'
import {showAction} from '~store/resourceAction'

export default {
  components: {
    ResourceDetail,
    ItemsTable,
    JournalEntryForm,
    PostJournalEntryForm
  },
  computed: {
    ...mapState({
      journalEntry: ({resource})=> resource.selected
    }),
    ...mapGetters('resource', {isSuccess})
  },
  methods: {
    ...mapMutations('resourceAction', {showAction}),
    post() {
      this.showAction({
        name: 'post_journal_entry',
        data: {id: this.journalEntry.id},
        confirmName: 'Post',
        confirmIcon: 'check',
        confirmColor: 'success'
      })
    },
    reject() {

    }
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
            account_id: null,
            left_value: null,
            right_value: null
          }
        ]
      }
    })
  }
}
</script>
