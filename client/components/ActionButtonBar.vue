<template>
  <b-button-group :class="[showDropdown?'show':'']" size="sm">
    <template v-for="a in shownActions">
      <slot :name="a.name">
        <!-- FIXME: b-tooltip is causing a bug with routing -->
        <!-- <b-tooltip :content="titleForAction(a)"> -->
          <b-button variant="secondary" :to="a.to" v-if="a.to" :disabled="a.disabled">
            <icon :name="a.icon"></icon>
          </b-button>
          <b-button variant="secondary" @click="clickAction(a)" :disabled="a.disabled" v-else>
            <icon :name="a.icon"></icon>
          </b-button>
        <!-- </b-tooltip> -->
      </slot>
    </template>
    <b-button variant="secondary" class="dropdown-toggle dropdown-toggle-split" v-if="burriedActions.length" @click.stop="toggleDropdown">
      <span class="sr-only">Toggle Dropdown</span>
    </b-button>
    <div :class="['dropdown-menu',right?'dropdown-menu-right':'']" v-if="showDropdown">
      <a :class="{'dropdown-item': true, disabled: a.disabled}" v-for="a in burriedActions" @click="clickAction(a)">
        {{a.name}}
      </a>
    </div>
  </b-button-group>
</template>

<script>
import {titleize} from 'inflection'
import {defer} from 'lodash'

export default {
  props: {
    actions: {
      type: Array,
      required: true
    },
    sizeLimit: {
      type: Number,
      default: 2
    },
    right: {
      type: Boolean,
      default: false
    },
    dropup: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    shownActions: ({actions, sizeLimit})=> actions.slice(0, sizeLimit),
    burriedActions: ({actions, sizeLimit})=> actions.slice(sizeLimit)
  },
  data: ()=> ({
    showDropdown: false,
    actionsPrivate: []
  }),
  mounted() {
    if (typeof document !== 'undefined') {
      document.documentElement.addEventListener('click', this.clickOut);
    }
  },
  methods: {
    clickAction(a) {
      if (a.disabled) {
        return
      } else if (!!a.action) {
        a.action()
      } else {
        return
      }
    },
    toggleDropdown() {
      this.showDropdown = !this.showDropdown
    },
    clickOut() {
      this.showDropdown = false
    },
    titleForAction: ({name})=> titleize(name),
    titleize
  },
  watch: {
    showDropdown(newValue, oldValue) {
      if (newValue == oldValue) {
        return
      }
      this.$emit(newValue?'dropdown-shown':'dropdown-hidden')
    }
  }
}
</script>
