<template>
  <resource-list no-add>
    <b-table class="table-striped" :items="changes" :fields="fields">
      <template slot="whodunnit" scope="x">
        <nuxt-link v-if="x.item.whodunnit" :to="{name: 'users-id', params: {id: x.item.whodunnit}}">{{x.item.whodunnit_name}}</nuxt-link>
        <span v-else class="text-muted">-UNSPECIFIED-</span>
      </template>
      <template slot="event" scope="x">
        <span v-if="x.item.event=='post'">
          <span class="text-success"><icon name="check"></icon> Post</span>
        </span>
        <span v-else-if="x.item.event=='reject'">
          <span class="text-danger"><icon name="times"></icon> Reject</span>
        </span>
        <span v-else>
          {{titleize(x.item.event)}}
        </span>
      </template>
      <template slot="item" scope="x">
        <span v-if="x.item.item_type == 'Account'">
          <nuxt-link :to="{name: 'accounts-id', params: {id: x.item.item_id}}">
            <small>{{x.item.object.code}}</small> {{x.item.object.name}}
          </nuxt-link>
        </span>
        <span v-else-if="x.item.item_type == 'JournalEntry'">
          <nuxt-link :to="{name: 'journals-id', params: {id: x.item.item_id}}">
            #{{x.item.item_id}}
          </nuxt-link>
        </span>
        <span v-else>
          {{x.item.item_type}} {{x.item.item_id}}
        </span>
      </template>
    </b-table>
  </resource-list>
</template>

<script>
import {mapState} from 'vuex'
import ResourceList from '~components/ResourceList'
import {titleize} from 'inflection'

export default {
  components: {
    ResourceList
  },
  computed: {
    ...mapState({
      changes: ({resource})=> resource.data
    })
  },
  async fetch({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'version',
      title: 'Changes'
    })
  },
  data: ()=> ({
    fields: {
      id: {label: 'ID'},
      created_at: {label: 'Time'},
      whodunnit: {label: 'User'},
      event: {label: 'Change'},
      item: {label: 'Target'}
    }
  }),
  methods: {
    titleize
  }
}
</script>
