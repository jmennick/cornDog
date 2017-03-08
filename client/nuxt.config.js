module.exports = {
  env: {
    apiUrl: process.env.API_URL || 'https://corndog.herokuapp.com/api'
  },
  build: {
    babel: {
      plugins: [
        'transform-async-to-generator',
        'transform-runtime'
      ],
      presets: [
        ['es2015', { modules: false }],
        'stage-2'
      ]
    },
    vendor: [
      'bootstrap-vue',
      'vue-awesome',
      'devour-client',
      'inflection',
      'format',
      'underscore'
    ]
  },
  router: {
    linkActiveClass: 'active'
  },
  plugins: [
    '~plugins/bootstrap-vue',
    '~plugins/vue-awesome',
    '~plugins/apiClient'
  ],
  head: {
    title: 'Corn Dog',
    meta: [
      {name: "Access-Control-Allow-Origin", value: "*"},
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1, shrink-to-fit=no' },
      { hid: 'description', name: 'description', content: 'Nuxt.js project' }
    ],
    link: [
      {rel:"stylesheet", href:"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css", integrity:"sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ", crossorigin:"anonymous"}
    ],
    scripts: [
      {src: "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js", integrity: "sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn", crossorigin: "anonymous"}
    ]
  },
  css: [
    {src: '~assets/css/main.scss', lang: 'scss'}
  ],
  loading: { color: '#3B8070' }
}
