<template>
  <div :class="{'show-sidebar': showSidebar}">
    <div id="content" class="theme-green">
      <b-navbar type="inverse" variant="chrome" class="fixed-top">
        <a class="navbar-brand text-white" @click="toggleSidebar()">
          <icon name="bars"></icon>
          <!-- <corndog-logo style="height: 23px; width: 23px; margin: -2px 4px 0 0" /> -->
          <!-- <span>CornDog Accounting</span> -->
        </a>
      </b-navbar>
      <nuxt/>
    </div>
    <div id="sidebar" class="bg-chrome-under">
      <ul class="nav flex-column ">
        <li class="nav-item">
          <a class="nav-link active" href="#">Active</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#">Disabled</a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import CorndogLogo from '~components/CorndogLogo'
import {mapState, mapMutations} from 'vuex'

export default {
  components: {
    CorndogLogo
  },
  computed: {
    ...mapState({
      showSidebar: ({sidebar})=> sidebar.shown
    })
  },
  methods: {
    ...mapMutations({
      toggleSidebar: 'sidebar/toggle'
    })
  }
}
</script>

<style>
#content {
  position: absolute;
  z-index: 100;
}
#content .content-container {
  position: fixed;
  z-index: 1040;
}
#content .navbar,
#content .content-container {
  -webkit-transition: left 0.2s;
  transition: left 0.2s;
}
.show-sidebar > #content .navbar,
.show-sidebar > #content .content-container {
  left: 200px;
}
#sidebar {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 0;
  -webkit-transition: width 0.2s;
  transition: width 0.2s;
  z-index: 4;
}
#sidebar > * {
  opacity: 0;
  -webkit-transition: opacity 0.2s;
  transition: opacity 0.2s;
}
.show-sidebar > #sidebar {
  width: 200px;
}
.show-sidebar > #sidebar > * {
  opacity: 1;
}
</style>
