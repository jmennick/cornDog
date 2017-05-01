<template>
  <resource-detail no-refresh return-location="/users">
    <form v-if="!!user">
      <b-form-fieldset label="Name" horizontal>
        <p class="form-control-static">{{user.name}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Email" horizontal>
        <p class="form-control-static">{{user.email}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Role" horizontal>
        <p class="form-control-static">{{user.role}}</p>
      </b-form-fieldset>
    </form>
  </resource-detail>
</template>

<script>
import {mapState} from 'vuex'
import ResourceDetail from '~components/ResourceDetail'

export default {
  components: {
    ResourceDetail
  },
  computed: {
    ...mapState({
      user: ({resource}) => resource.selected
    })
  },
  async fetch ({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'user',
      id: params.id,
      newResource: {
        name: null,
        email: null,
        role: 'no_access',
        password: null
      }
    })
  }
}
</script>
