<template>
  <resource-list no-add>
    <b-table class="table-striped" :items="changes" :fields="fields" v-if="changes">
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
        <span v-else-if="x.item.event=='activate'">
          <span class="text-success"><icon name="thumbs-up"></icon> Activate</span>
        </span>
        <span v-else-if="x.item.event=='deactivate'">
          <span class="text-danger"><icon name="thumbs-down"></icon> Deactivate</span>
        </span>
        <span v-else>
          {{titleize(x.item.event)}}
        </span>
      </template>
      <template slot="item" scope="x">
        <span v-if="x.item.item_type == 'Account'">
          <nuxt-link :to="{name: 'accounts-id', params: {id: x.item.item_id}}">
            <small>{{objectProp(x.item, 'code')}}</small> {{objectProp(x.item, 'name')}}
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
import {get} from 'lodash'

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
      title: 'Events'
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
    titleize,
    objectProp(change, propName) {
      return get(change,
        `object_changes.${propName}[1]`,
        get(change, `object.${propName}`)
      )
    }
  }
}
</script>
