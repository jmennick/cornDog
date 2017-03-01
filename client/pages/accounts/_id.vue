<template>
  <resource-detail>
    <form>
      <b-form-fieldset label="Account Name" horizontal>
        <p class="form-control-static">{{account.name}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Account Kind" horizontal>
        <p class="form-control-static">{{account.kind_human}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Initial Balance" horizontal>
        <p class="form-control-static">{{account.initial_balance}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Code" horizontal>
        <p class="form-control-static">{{account.code}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Order" horizontal>
        <p class="form-control-static">{{account.order}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Active" horizontal>
        <p class="form-control-static">{{account.active}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Description" horizontal>
        <p class="form-control-static">{{account.description}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Created By" horizontal>
        <p class="form-control-static">{{account.created_by.name}}</p>
      </b-form-fieldset>
      <b-form-fieldset label="Date Added" horizontal>
        <p class="form-control-static">{{account.created_at}}</p>
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
        account: ({resource}) => resource.data
      })
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'accounts',
        id: params.id,
        query: {include: 'created_by'}
      })
    }
  }
</script>
