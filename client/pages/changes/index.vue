<template>
  <resource-list no-add>
    <b-list-group v-if="changes.length">
      <b-list-group-item v-for="c in changes">
        <div class="d-flex w-100 justify-content-between">
          <h6 class="mb-1">
            <nuxt-link v-if="c.whodunnit" :to="{name: 'users-id', params: {id: c.whodunnit}}">{{c.whodunnit_name}}</nuxt-link>
            <event-label :change="c"></event-label>
            <target-label :change="c"></target-label>
          </h6>
          <small>{{c.created_at}}</small>
        </div>
        <details-label :change="c"></details-label>
      </b-list-group-item>
    </b-list-group>
  </resource-list>
</template>

<script>
import {mapState} from 'vuex'
import ResourceList from '~components/ResourceList'
import EventLabel from '~components/changes/EventLabel'
import TargetLabel from '~components/changes/TargetLabel'
import DetailsLabel from '~components/changes/DetailsLabel'
import {reverse, get} from 'lodash'

export default {
  components: {
    ResourceList,
    EventLabel,
    TargetLabel,
    DetailsLabel
  },
  computed: {
    ...mapState({
      changes: ({resource}) => reverse(get(resource, 'data', []))
    })
  },
  async fetch ({params, store}) {
    await store.dispatch('resource/setup', {
      name: 'version',
      listRouteName: 'changes',
      title: 'Events'
    })
  }
}
</script>
