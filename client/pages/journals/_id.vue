<template>
  <resource-detail v-if="!!journalEntry">
    <journal-entry-form slot="form"/>
    <post-journal-entry-form slot="post_journal_entry"/>
    <post-journal-entry-form slot="reject_journal_entry"/>
    <form v-if="!!journalEntry">
      <div class="container-fluid">
        <b-form-fieldset label="Created By" horizontal>
          <p class="form-control-static">{{journalEntry.created_by.name}}</p>
        </b-form-fieldset>
        <b-form-fieldset label="Date" horizontal>
          <p class="form-control-static">{{journalEntry.date}}</p>
        </b-form-fieldset>
      </div>
      <items-table :journal-entry="journalEntry"></items-table>
    </form>
    <div class="container-fluid row justify-content-center">
      <div class="col-xl-4 col-lg-6 col-md-8 col-sm-12">
        <div v-if="journalEntry.state == 'pending'" class="card card-outline-secondary text-secondary text-center">
          <div class="card-block">
            <h4 class="card-title">Pending Review</h4>
            <div class="row justify-content-center">
              <b-button-group toolbar size="lg">
                <b-button variant="danger" @click="reject" :disabled="!isSuccess">
                  <icon name="times"></icon> Reject
                </b-button>
                &nbsp;&nbsp;
                <b-button variant="success" @click="post" :disabled="!isSuccess">
                  <icon name="check"></icon> Post
                </b-button>
              </b-button-group>
            </div>
          </div>
        </div>
        <div v-else-if="journalEntry.state == 'posted'" class="card card-outline-success text-success text-center">
          <div class="card-block">
            <h4 class="card-text">
              <strong><icon name="check"></icon> Posted</strong>
              &nbsp;by Joe Admin
            </h4>
          </div>
        </div>
        <div v-else-if="journalEntry.state == 'rejected'" class="card card-outline-danger text-danger text-center">
          <div class="card-block">
            <h4 class="card-text">
              <strong><icon name="times"></icon> Rejected</strong>
              &nbsp;by Joe Admin
            </h4>
          </div>
        </div>
        <div v-else class="card card-outline-warning text-warning text-center">
          <div class="card-block">
            <h4 class="card-text">
              <strong><icon name="question"></icon> Unknown State</strong>
            </h4>
          </div>
        </div>
        <br />
      </div>
    </div>
    <form class="">
      <div class="container-fluid">
        <b-form-fieldset label="Description">
          <p class="form-control-static">
            <span v-if="journalEntry.description">
              {{journalEntry.description}}
            </span>
            <span v-else class="text-muted">
              No Description Provided
            </span>
          </p>
        </b-form-fieldset>
        <b-form-fieldset label="Source Documents">
          <p class="form-control-static">
            <ul v-if="journalEntry.source_documents.length">
              <li v-for="doc in journalEntry.source_documents">
                <a :href="fileURL(doc)" target="_blank">
                  <icon name="file"></icon> {{doc.name}}
                </a>
              </li>
            </ul>
            <span v-else class="text-muted">
              No Source Documents Provided
            </span>
          </p>
        </b-form-fieldset>
    </form>
  </resource-detail>
</template>

<script>
import {mapState, mapMutations, mapGetters} from 'vuex'
import ResourceDetail from '~components/ResourceDetail'
import ItemsTable from '~components/journal_entries/ItemsTable'
import PostJournalEntryForm from '~components/journal_entries/PostJournalEntryForm'
import JournalEntryForm from '~components/JournalEntryForm'
import {isSuccess} from '~store/resource'
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
      journalEntry: ({resource}) => resource.selected
    }),
    ...mapGetters('resource', {isSuccess})
  },
  methods: {
    ...mapMutations('resourceAction', {showAction}),
    post () {
      this.showAction({
        name: 'post_journal_entry',
        data: {id: this.journalEntry.id},
        confirmName: 'Post',
        confirmIcon: 'check',
        confirmColor: 'success'
      })
    },
    reject () {
      this.showAction({
        name: 'reject_journal_entry',
        data: {id: this.journalEntry.id},
        confirmName: 'Reject',
        confirmIcon: 'times',
        confirmColor: 'danger'
      })
    },
    fileURL (doc) {
      return JSON.parse(doc.data)
    }
  },
  async fetch ({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'journal_entry',
      listRouteName: 'journals',
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
