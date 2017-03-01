<template>
  <resource-detail>
    <form>
      <b-form-fieldset label="Created By" horizontal>
        <p class="form-control-static">{{journalEntry.created_by.name}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Created At" horizontal>
        <p class="form-control-static">{{journalEntry.created_at}}</p>
      </b-form-fieldset>
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
  }
}
</script>
