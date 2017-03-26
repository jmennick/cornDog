<template>
  <resource-list @saved="handleSaved">
    <b-table stripped :items="users" :fields="fields" class="no-bottom-margin">
      <template slot="role" scope="x">
        {{titleize(x.item.role)}}
      </template>
      <template slot="actions" scope="x">
        <action-button-bar :actions="actions(x.item)" right>
        </action-button-bar>
      </template>
    </b-table>
  </resource-list>
</template>

<script>
import {mapState, mapMutations} from 'vuex'
import ResourceList from '~components/ResourceList'
import ActionButtonBar from '~components/ActionButtonBar'
import {titleize} from 'inflection'

export default {
  components: {
    ResourceList,
    ActionButtonBar
  },
  computed: {
    ...mapState({
      users: ({resource})=> resource.data
    })
  },
  async fetch({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'user',
      newResource: {
        name: null,
        email: null,
        role: 'no_access',
        password: null
      }
    })
  },
  data: ()=> ({
    fields: {
      name: {label: 'Name'},
      email: {label: 'Email'},
      role: {label: 'Role'},
      actions: {sortable: false}
    }
  }),
  methods: {
    handleSaved(event) {
      this.$router.push({name: 'users-id', params: {id: event.id}})
    },
    actions(user) {
      return [
        {
          icon: 'eye',
          name: 'show',
          to: {name: 'users-id', params: {id: user.id}}
        }
      ]
    },
    titleize: titleize
  }
}
</script>
