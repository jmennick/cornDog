<template>
  <resource-list no-add>
    <div slot="form">
      <account-form />
    </div>
    <b-table class="table-striped" :items="accounts" :fields="fields">
      <template slot="actions" scope="a">
        <action-button-bar :actions="actions(a.item)" right>
        </action-button-bar>
        <!--<b-button size="sm" class="mr-2"><icon name="eye"></icon></b-button>-->
      </template>
    </b-table>
  </resource-list>
</template>
<script>
import {mapState} from 'vuex'
import ResourceList from '~components/ResourceList'
import ActionButtonBar from '~components/ActionButtonBar'

export default {
  components: {
    ResourceList,
    ActionButtonBar
  },
  computed: {
    ...mapState({
      accounts: ({resource})=> resource.data
    })
  },
  methods: {
    actions(account) {
      return [
        {
          icon: 'eye',
          name: 'show',
          to: {name: 'id', params: {id: account.id}}
        }
      ]
    }
  },
  async fetch({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'account',
      listRouteName: 'index',
      showRouteBase: '',
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
