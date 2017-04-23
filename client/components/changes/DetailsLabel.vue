<template>
  <div class="d-flex w-100 justify-content-between">
    <span v-if="change.item_type === 'Account'">
      <span v-if="change.event === 'create' || change.event === 'update'">
        <div :class="{collapse: true, show: !collapsed}">
          <dl class="row no-bottom-margin" style="width: 100%">
            <dt class="col-sm-2">Name</dt>
            <dd class="col-sm-10">
              <changed-property :value="change.object_changes.name[1]">
              </changed-property>
            </dd>
            <dt class="col-sm-2">Code</dt>
            <dd class="col-sm-4">
              <changed-property :value="change.object_changes.code[1]">
              </changed-property>
            </dd>
            <dt class="col-sm-2">Order</dt>
            <dd class="col-sm-4">
              <changed-property :value="change.object_changes.order[1]">
              </changed-property>
            </dd>
            <dt class="col-sm-2">Description</dt>
            <dd class="col-sm-10">
              <changed-property :value="change.object_changes.description[1]">
              </changed-property>
            </dd>
          </dl>
        </div>
        <a @click="toggleCollapsed" href="javascript:;">
          <span v-if="collapsed">More <icon name="caret-down"></icon></span>
          <span v-else>Less <icon name="caret-up"></icon></span>
        </a>
      </span>
    </span>
    <span v-else-if="change.item_type === 'JournalEntry'">
      <span v-if="change.event === 'create' || change.event === 'update'">
        <div :class="{collapse: true, show: !collapsed}">
          <dl class="row no-bottom-margin" style="width: 100%">
            <dt class="col-sm-2">Date</dt>
            <dd class="col-sm-10">
              <changed-property :value="change.object_changes.date[1]">
              </changed-property>
            </dd>
            <dt class="col-sm-2">Items</dt>
            <dd class="col-sm-10">
              See <nuxt-link :to="{name: 'journals-id', params: {id: change.item_id}}">
                original journal entry
              </nuxt-link>
            </dd>
          </dl>
        </div>
        <a @click="toggleCollapsed" href="javascript:;">
          <span v-if="collapsed">More <icon name="caret-down"></icon></span>
          <span v-else>Less <icon name="caret-up"></icon></span>
        </a>
      </span>
    </span>
  </div>
</template>

<script>
import ChangedProperty from './ChangedProperty'

export default {
  props: {
    change: {
      type: Object,
      required: true
    }
  },
  methods: {
    toggleCollapsed () {
      this.collapsed = !this.collapsed
    }
  },
  data: () => ({
    collapsed: true
  }),
  components: {
    ChangedProperty
  }
}
</script>
