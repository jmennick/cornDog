<template>
  <resource-list no-add>
    <div slot="form">
      <account-form />
    </div>
    <b-table class="table-striped" :items="accounts" :fields="fields">
      <template slot="actions" scope="account">
        <b-button size="sm" class="mr-2"><icon name="eye"></icon></b-button>
      </template>
    </b-table>
  </resource-list>
</template>
<script>
import {mapState} from 'vuex'
import ResourceList from '~components/ResourceList'

export default {
  components: {
    ResourceList
  },
  computed: {
    ...mapState({
      accounts: ({resource})=> resource.data
    })
  },
  async fetch({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'account',
      title: 'Chart of Accounts',
      query: {
        filter: {active: true},
        include: 'created_by'
      }
    })
  },
  data: ()=> ({
    fields: {
      code: {label: 'Code', sortable: true},
      name: {label: 'Name', sortable: true},
      kind_human: {label: 'Kind', sortable: true},
      actions: {sortable: false}
    }
  })
}
</script>
