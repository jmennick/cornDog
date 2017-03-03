<template>
  <b-button-group size="sm" :class="[showDropdown?'show':'']">
    <template v-for="a in shownActions">
      <slot :name="a.name">
        <b-button variant="secondary" :to="a.to" @click="clickAction(a)">
          <icon :name="a.icon"></icon>
        </b-button>
      </slot>
    </template>
    <b-button variant="secondary" class="dropdown-toggle dropdown-toggle-split" v-if="burriedActions.length" @click="toggleDropdown">
      <span class="sr-only">Toggle Dropdown</span>
    </b-button>
    <div :class="['dropdown-menu',right?'dropdown-menu-right':'']" v-if="showDropdown">
      <a class="dropdown-item" v-for="a in burriedActions" @click="clickAction(a)">
        {{a.name}}
      </a>
    </div>
  </b-button-group>
</template>

<script>
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
    showDropdown: false
  }),
  mounted() {
    if (typeof document !== 'undefined') {
      document.documentElement.addEventListener('click', this.clickOut);
    }
  },
  methods: {
    clickAction(a) {
      if (!!a.action) {
        a.action()
      } else {
        return
      }
    },
    toggleDropdown() {
      this.setShowDropdown(!this.showDropdown)
    },
    setShowDropdown(value) {
      if (this.showDropdown === value) {
        return;
      } // Avoid duplicated emits
      this.showDropdown = value;
      if (this.showDropdown) {
        this.$emit('dropdown-shown');
      } else {
        this.$emit('dropdown-hidden');
      }
    },
    clickOut() {
      this.setShowDropdown(false);
    }
  }
}
</script>
