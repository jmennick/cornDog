<template>
  <resource-list resource="account" resource-label-singular="Chart of Account" resource-label-plural="Chart Of Accounts">
    <div slot="form">
      <account-form />
    </div>
    <b-table stripped :items="accounts" :fields="fields">
      <template slot="actions" scope="account">
        <b-button size="sm" class="mr-2"><icon name="eye"></icon></b-button>
        <b-button size="sm" class="mr-2"><icon name="edit"></icon></b-button>
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
    await store.dispatch('resource/fetch', 'account', { filter: {active: true}})
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
