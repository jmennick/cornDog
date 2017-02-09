<template>
  <div>
    <v-nav nav-class="blue">
      <nuxt-link to="/" class="brand-logo" slot="logo">Corndog</nuxt-link>
      <ul class="right">
        <li>
          <a href="/">Home</a>
        </li>
        <li>
          <nuxt-link to="accounts">Accounts</nuxt-link>
        </li>
        <li>
          <nuxt-link to="journal" >Transactions</nuxt-link>
        </li>
      </ul>
      <v-side-nav id="side2" slot="side-nav"></v-side-nav>
    </v-nav>
    <nuxt-loading ref="loading"></nuxt-loading>

    <nuxt/>
    <my-footer/>
  </div>
</template>

<script>
import MyFooter from '~components/Footer.vue'

export default {
  components: {
    MyFooter
  }
}
</script>

<style>
.container
{
  /*margin: 0;*/
  /*width: 100%;*/
  padding: 25px 0 100px 0;
  text-align: center;
}

.button, .button:visited
{
  display: inline-block;
  color: #3B8070;
  letter-spacing: 1px;
  background-color: #fff;
  border: 2px solid #3B8070;
  text-decoration: none;
  text-transform: uppercase;
  padding: 15px 45px;
}

.button:hover, .button:focus
{
  color: #fff;
  background-color: #3B8070;
}

.title
{
  color: #505153;
  font-weight: 300;
  font-size: 2.5em;
  margin: 0;
}
</style>
