<template>
  <resource-detail no-add no-refresh return-location="/">
    <div slot="form">
      <account-form/>
    </div>
    <form v-if="!!account">
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
        <p class="form-control-static">
          <nuxt-link :to="{name: 'users-id', params: {id: account.created_by.id}}">
            {{account.created_by.name}}
          </nuxt-link>
        </p>
      </b-form-fieldset>
      <b-form-fieldset label="Created At" horizontal>
        <p class="form-control-static">{{account.created_at}}</p>
      </b-form-fieldset>
    </form>
  </resource-detail>
</template>

<script>
  import {mapState} from 'vuex'
  import ResourceDetail from '~components/ResourceDetail'
  import AccountForm from '~components/accounts/AccountForm'
  import {selected} from '~store/resource'

  export default {
    components: {
      ResourceDetail,
      AccountForm
    },
    computed: {
      ...mapState({
        account: ({resource}) => resource.selected
      })
    },
    async fetch({params, store}) {
      await store.dispatch('resource/setup', {
        name: 'account',
        id: params.id,
        query: {include: 'created_by'},
        newResource: {
          active: false,
          code: null,
          description: null,
          kind: 'current_asset',
          created_by_id: 1,
          initial_balance: 0.0,
          name: null,
          order: null,
          type: 'accounts'
        }
      })
    }
  }
</script>
