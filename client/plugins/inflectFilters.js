import Vue from 'vue'

import {
  singularize, pluralize, humanize, capitalize, titleize
} from 'inflection'

Vue.filter('singularize', (value) => singularize(value))
Vue.filter('pluralize', (value) => pluralize(value))
Vue.filter('humanize', (value) => humanize(value))
Vue.filter('capitalize', (value) => capitalize(value))
Vue.filter('titleize', (value) => titleize(value))
