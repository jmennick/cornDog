import Vue from 'vue'
import numeral from 'numeral'

Vue.filter('currency', (value, showSign = false) => {
  const f = (showSign ? '($0,0.00)' : '(0,0.00)')
  return numeral(value).format(f)
})
