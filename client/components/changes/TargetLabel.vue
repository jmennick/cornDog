<template>
  <span>
    <span v-if="change.item_type === 'Account'">
      Account <nuxt-link :to="{name: 'accounts-id', params: {id: change.item_id}}">
        <small>{{objectProp('code')}}</small>
        {{objectProp('name')}}
      </nuxt-link>
    </span>
    <span v-else-if="change.item_type === 'JournalEntry'">
      Journal Entry <nuxt-link :to="{name: 'journals-id', params: {id: change.item_id}}">
        #{{change.item_id}}
      </nuxt-link>
    </span>
    <span v-else>
      {{change.item_type}} #{{change.item_id}}
    </span>
  </span>
</template>

<script>
import {get} from 'lodash'

export default {
  props: {
    change: {
      type: Object,
      required: true
    }
  },
  methods: {
    objectProp (propName) {
      return get(this.change,
        `object_changes.${propName}[1]`,
        get(this.change, `object.${propName}`)
      )
    }
  }
}
</script>
