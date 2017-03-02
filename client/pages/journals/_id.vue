<template>
  <resource-detail>
    <form>
      <b-form-fieldset label="Created By" horizontal>
        <p class="form-control-static">{{journalEntry.created_by.name}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Created At" horizontal>
        <p class="form-control-static">{{journalEntry.created_at}}</p>
      </b-form-fieldset>
      <b-table stripped :items="journalEntry.items" :fields="fields">
        <template slot="credit" scope="j">
          <span v-if="isCredit(j.item)">{{j.item.amount}}</span>
        </template>
        <template slot="debit" scope="j">
          <span v-if="isDebit(j.item)">{{j.item.amount}}</span>
        </template>
      </b-table>
    </form>
  </resource-detail>
</template>

<script>
import {mapState} from 'vuex'
import ResourceDetail from '~components/ResourceDetail'
import {selected} from '~store/resource'

export default {
  components: {
    ResourceDetail
  },
  data: ()=> ({
    fields: {
      date: {label: 'Date'},
      credit: {label: 'Credit'},
      debit: {label: 'Debit'}
    }
  }),
  computed: {
    ...mapState({
      journalEntry: ({resource})=> resource.selected
    })
  },
  async fetch({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'journal_entry',
      id: params.id,
      query: {include: 'created_by'}
    })
  },
  methods: {
    isCredit: (entry)=> entry.normal_side == 'left',
    isDebit: (entry)=> entry.normal_side == 'right'
  }
}
</script>
