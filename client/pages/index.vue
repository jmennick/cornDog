<template>
  <resource-list resource="account" resource-label-singular="Account" resource-label-plural="Accounts">
    <table class="table table-striped no-bottom-margin">
      <thead>
        <tr>
          <th>Code</th>
          <th>Name</th>
          <th>Kind</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="a in accounts">
          <td>{{a.code}}</td>
          <td>{{a.name}}</td>
          <td>{{a.kind_human}}</td>
          <td class="d-flex justify-content-end td-actions"><div class="btn-toolbar">
            <b-button size="sm" class="mr-2"><icon name="eye"></icon></b-button>
            <b-button size="sm" class="mr-2"><icon name="edit"></icon></b-button>
            <b-button size="sm"><icon :name="activeToggleLabel(a)"></icon></b-button>
          </div></td>
        </tr>
      </tbody>
    </table>
  </resource-list>
</template>

<script>
import ResourceList from '~components/ResourceList'
import {mapState} from 'vuex'

export default {
  components: {
    ResourceList
  },
  computed: {
    ...mapState({
      accounts: ({resource})=> resource.data
    })
  },
  methods: {
    activeToggleLabel(account) {
      return account.active ? 'ban' : 'thumb-tack'
    }
  },
  async fetch({params, store}) {
    await store.dispatch('resource/fetch', 'account')
  }
}
</script>
